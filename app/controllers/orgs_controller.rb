class OrgsController < ApplicationController
  skip_before_action :authenticate_request, only: [:show, :create]
  before_action :set_org, only: [:show, :update, :destroy]

  # GET /orgs
  def index
    @orgs = Org.all

    render json: @orgs, :include => [:jobs]
  end

  # GET /orgs/1
  def show
    render json: @org
  end

  # GET /orgs/showPostings
  def show_postings
    @org = @current_user.org
    @jobs = @org.jobs.left_outer_joins(:periods).where("periods.id IS NULL OR periods.date >= :today", :today => Date.today).uniq
    @jobs_json = ActiveModel::SerializableResource.new(
      @jobs,
      each_serializer: ActiveModel::Serializer::JobSerializer
    )
    # @quick_jobs = sort(@jobs.where(:job_type => :quick))
    # @stable_jobs = sort(@jobs.where(:job_type => :stable))
    # @interns = sort(@jobs.where(:job_type => :intern))
    # @projects = sort(@jobs.where(:job_type => :project))
    render :json => {
      :me => @current_user.as_json,
      :org => @org.as_json,
      :jobs => @jobs_json
      # :quick_jobs => @quick_jobs.collect{ |job| job.as_json(:include => [ {:employment_types => {:only => [:name]}}, :orgs, :locations, :periods, :langs] )},
      # :stable_jobs => @stable_jobs.collect{ |job| job.as_json(:include => [ {:employment_types => {:only => [:name]}}, :orgs, :locations, :periods, :langs] )},
      # :interns => @interns.collect{ |job| job.as_json(:include => [ {:employment_types => {:only => [:name]}}, :orgs, :locations, :periods, :langs] )},
      # :projects => @projects.collect{ |job| job.as_json(:include => [ {:employment_types => {:only => [:name]}}, :orgs, :locations, :periods, :langs] )}
    }
  end

  # GET /orgs/whoAreWe
  def who_are_we
    @org = Org.find(@current_user.org.id)
    employers = @org.employers
    render :json => {
      :me => @current_user.as_json,
      :org => @org.as_json,
      :employers => employers.as_json
    }
  end

  # POST /orgs
  def create
    @org = Org.new(org_params)
    
    if @org.save
      @employer = Employer.new(employer_params)
      @employer.admin = true
      @employer.org = @org
      @org.email = @employer.email
      if @employer.save && @org.save
        @command = AuthenticateUser.call('employer', @employer.email, @employer.password)
        if @command.success?
          render json: {employer: @employer, org: @org, auth_token: @command.result }, status: :created
        else
          @employer.destroy
          @org.destroy
          render json: { error: @command.errors }, status: :unauthorized
        end
      else
        @org.destroy
        render json: @employer.errors, status: :unprocessable_entity
      end
    else
      render json: @org.errors, status: :unprocessable_entity
    end
  end

  # # POST /orgs
  # def create
  #   @org = Org.new(org_params)

  #   if @org.save
  #     render json: @org, status: :created, location: @org
  #   else
  #     render json: @org.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /orgs/1
  def update
    if @org.update(org_params)
      render json: @org
    else
      render json: @org.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orgs/1
  def destroy
    @org.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def org_params
      params.require(:org).permit(:name, :description, :country, :region, :address, :logo, :email)
    end

    def employer_params
      params.require(:org).permit(:email, :password)
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
