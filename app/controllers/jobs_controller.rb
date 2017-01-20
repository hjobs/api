class JobsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :index]
  before_action :set_job, only: [:show, :update, :destroy]

  # GET /jobs
  def index
    @jobs = Job.all

    render json: @jobs
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
      if @oj.save
        render json: @job, status: :created
      else
        @job.destroy
        render json: @oj.errors, status: :unprocessable_entity
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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:title, :description, :deadline, :salary_type, :salary_value, :salary_high, :salary_low, :salary_unit, :position, :attachment_url, :employment_type)
    end

    def org_job_params
       params.require(:job).permit(:org_id)
    end
end
