class JobsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :index, :show_job_type, :get_picked]
  before_action :set_job, only: [:show, :update, :destroy]

  has_scope :by_job_type, allow_blank: true, default: "quick"
  has_scope :after_today, allow_blank: true, default: true
  has_scope :offset_by, allow_blank: true, default: 0

  # GET /jobs
  def index
    @jobs = apply_scopes(Job)
    render json: {
      :jobs => ActiveModel::SerializableResource.new(
        @jobs,
        each_serializer: JobSerializer
      ),
      :total_count => @jobs.unscope(:offset, :limit).count
    }
  end

  # GET /jobs/1
  def show
    job_poster = @job.employer
    
    is_authorised = (
      @iam == "employee" ||
      (
        job_poster == @current_user ||
        @job.orgs.include?(@current_user.org)
      )
    )

    unless is_authorised
      render status: :unauthorized
      return 
    end

    render json: @job
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.employer = @current_user

    if @job.save

      @oj = OrgJob.new()
      logger.debug 'log current_user'
      logger.debug @current_user.email
      @oj.org = @current_user.org
      @oj.job = @job

      unless add_employment_types && add_employment_types && set_locations && add_periods && add_langs
        @job.destroy
        return
      end

      if @oj.save
        render json: @job, status: :created
      else
        @job.destroy
        render json: @oj.errors || @job_employment_type.errors, status: :unprocessable_entity
      end
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params) && add_periods && add_langs && set_locations
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    jobs = @current_user.org.jobs.sort_by {|x| x.updated_at}.reverse
    render json: {jobs: jobs}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(
        :id, :title, :description, :deadline, :job_type, :event,
        :salary_type, :salary_value, :salary_high, :salary_low, :salary_unit,
        :position, :attachment_url, :employment_types, :periods,
        :default_location, :has_bonus, :bonus_value
      )
    end

    def add_employment_types
      logger.debug "inside add_employment_types"
      params[:job][:employment_types] ||= []
      params[:job][:employment_types].each do |employment_type|
        logger.debug employment_type
			  @e_type = EmploymentType.find_by(name: employment_type)
        logger.debug "@e_type.name"
        logger.debug @e_type.name
        @j_e_t = JobEmployementType.find_or_initialize_by(:job => @job, :employment_type => @e_type)
        unless @j_e_t.save
          render json: @j_e_t.errors, status: :unprocessable_entity
          return false
        end
			end
      return true
    end

    def add_periods
      p_params = params.require(:job).permit(:periods => [[:date, :start_time, :end_time]])
      return true if !p_params[:periods] || p_params[:periods].empty?
      period_arr = []
      p_params[:periods].each do |period|
        logger.debug period
        p = {}
        p[:date] = Date.parse(period[:date]) if period[:date]
        p[:start_time] = Time.parse(period[:start_time]) if period[:start_time]
        p[:end_time] = Time.parse(period[:end_time]) if period[:end_time]
        @period = Period.find_or_initialize_by(p)
        if @period.save
          period_arr << @period
        else
          period_arr.each do |period| period.destroy end
          render json: @period.errors, status: :unprocessable_entity
          return false
        end

        @job_period = JobPeriod.find_or_initialize_by(job: @job, period: @period)
        unless @job_period.save
          render json: @job_period.errors, status: :unprocessable_entity
          return false
        end
      end
      return true
    end

    def set_locations
      l_params = params.require(:job).permit(:locations => [[:id, :address, :street, :country, :region, :city, :lat, :lng, :_destroy]])
      # logger.debug "l_param.empty? || !l_param.key?(:location)"
      return true if l_params.empty?
      return true if params[:job][:default_location]

      l_params[:locations].each do |l_param|
        if l_param[:_destroy] == true
          l = Location.find_by_id(l_param[:id])
          jl = JobLocation.find_by(:job => @job, :location => l)
          unless l && jl && jl.destroy
            render status: :unprocessable_entity
            return false
          end
        else
          l = Location.find_by(:lat => l_param[:lat], :lng => l_param[:lng])
          l = Location.find_by(:street => l_param[:street]) if !l
          l = Location.new(l_param) if !l
          unless l.save
            render json: l.errors, status: :unprocessable_entity
            return false
          end
          jl = JobLocation.find_or_initialize_by(:location => l, :job => @job)
          unless jl.save
            render json: jl.errors, status: :unprocessable_entity
            return false
          end
        end
      end
      true
    end

    def add_langs
      job_lang_arr = []
      params[:job][:langs] ||= []
      params[:job][:langs].each do |lang|
        logger.debug lang
        @lang = Lang.find_by_code(lang)
        unless @lang
          render json: {error: "no language found from parameters"}
          return false
        end
        
        @job_lang = JobLang.find_or_initialize_by(:lang => @lang, :job => @job)
        if @job_lang.save
          job_lang_arr << @job_lang
        else
          job_lang_arr.each do |job_lang| job_lang.destroy end
          render json: @job_lang.errors, status: :unprocessable_entity
          return false
        end
      end
      return true
    end

    def org_job_params
       params.require(:job).permit(:org_id)
    end

    def sort(jobs)
      jobs.sort_by { |j|
        if j.periods.empty?
          j.updated_at
        else
          j.periods[0].date
        end
      }.reverse
    end
end
