class OrgJobsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_org_job, only: [:show, :update, :destroy]

  # GET /org_jobs
  def index
    @org_jobs = OrgJob.all

    render :json => @org_jobs.sort_by{|item| item.updated_at}.reverse!, :include => [:org]
  end

  # GET /org_jobs/1
  def show
    render json: @org_job
  end

  # POST /org_jobs
  def create
    @org_job = OrgJob.new(org_job_params)

    if @org_job.save
      render json: @org_job, status: :created, location: @org_job
    else
      render json: @org_job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /org_jobs/1
  def update
    if @org_job.update(org_job_params)
      render json: @org_job
    else
      render json: @org_job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /org_jobs/1
  def destroy
    @org_job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org_job
      @org_job = OrgJob.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def org_job_params
      params.require(:org_job).permit(:org_id, :job_id)
    end
end
