class JobsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :index, :show_job_type]
  before_action :set_job, only: [:show, :update, :destroy]

  # GET /jobs
  def index
    @jobs = Job.all
    render json: @jobs.sort_by {|x| x.updated_at}.reverse, :include => [:employment_types, {:org => {:include => [:employers]}}]
  end

  def show_job_type
    job_type_id = Job.job_types[params[:job_type]]
    # logger.debug "job_type_id = "
    # logger.debug job_type_id
    @jobs = Job.where({job_type: job_type_id})
    # logger.debug "job_type = "
    # logger.debug params[:job_type]
    render json: @jobs.sort_by {|x| x.updated_at}.reverse, :include => [:employment_types, {:orgs => {:include => [:employers]}}]
  end

  # GET /jobs/1
  def show
    render json: @job
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)

    if @job.save

      @oj = OrgJob.new()
      logger.debug 'log current_user'
      logger.debug @current_user.email
      @oj.org = @current_user.org
      @oj.job = @job

      unless add_employment_types
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
    if @job.update(job_params)
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
      params.require(:job).permit(:title, :description, :deadline, :salary_type, :salary_value, :salary_high, :salary_low, :salary_unit, :position, :attachment_url, :employment_types, :job_type)
    end

    def add_employment_types
      logger.debug "inside add_employment_types"
      params[:job][:employment_types] ||= []
      params[:job][:employment_types].each do |employment_type|
        logger.debug employment_type
			  @e_type = EmploymentType.find_by(name: employment_type)
        logger.debug "@e_type.name"
        logger.debug @e_type.name
        @j_e_t = JobEmploymentType.new()
        @j_e_t.job = @job
        @j_e_t.employment_type = @e_type
        unless @j_e_t.save
          render json: @j_e_t.errors, status: :unprocessable_entity
          return false
        end
			end
      return true
    end

    def org_job_params
       params.require(:job).permit(:org_id)
    end
end
