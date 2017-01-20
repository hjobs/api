class JobEmploymentTypesController < ApplicationController
  before_action :set_job_employment_type, only: [:show, :update, :destroy]

  # GET /job_employment_types
  def index
    @job_employment_types = JobEmploymentType.all

    render json: @job_employment_types
  end

  # GET /job_employment_types/1
  def show
    render json: @job_employment_type
  end

  # POST /job_employment_types
  def create
    @job_employment_type = JobEmploymentType.new(job_employment_type_params)

    if @job_employment_type.save
      render json: @job_employment_type, status: :created, location: @job_employment_type
    else
      render json: @job_employment_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_employment_types/1
  def update
    if @job_employment_type.update(job_employment_type_params)
      render json: @job_employment_type
    else
      render json: @job_employment_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_employment_types/1
  def destroy
    @job_employment_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_employment_type
      @job_employment_type = JobEmploymentType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_employment_type_params
      params.require(:job_employment_type).permit(:job_id, :employment_type_id)
    end
end
