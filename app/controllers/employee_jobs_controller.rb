class EmployeeJobsController < ApplicationController
  before_action :set_employee_job, only: [:show, :update, :destroy]

  # GET /employee_jobs
  def index
    @employee_jobs = EmployeeJob.all

    render json: @employee_jobs
  end

  # GET /employee_jobs/1
  def show
    render json: @employee_job
  end

  # POST /employee_jobs
  def create
    @employee_job = EmployeeJob.new(employee_job_params)

    if @employee_job.save
      render json: @employee_job, status: :created, location: @employee_job
    else
      render json: @employee_job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employee_jobs/1
  def update
    if @employee_job.update(employee_job_params)
      render json: @employee_job
    else
      render json: @employee_job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employee_jobs/1
  def destroy
    @employee_job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_job
      @employee_job = EmployeeJob.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_job_params
      params.require(:employee_job).permit(:status, :message, :job_id, :employee_id)
    end
end
