class JobLocationsController < ApplicationController
  before_action :set_job_location, only: [:show, :update, :destroy]

  # GET /job_locations
  def index
    @job_locations = JobLocation.all

    render json: @job_locations
  end

  # GET /job_locations/1
  def show
    render json: @job_location
  end

  # POST /job_locations
  def create
    @job_location = JobLocation.new(job_location_params)

    if @job_location.save
      render json: @job_location, status: :created, location: @job_location
    else
      render json: @job_location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_locations/1
  def update
    if @job_location.update(job_location_params)
      render json: @job_location
    else
      render json: @job_location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_locations/1
  def destroy
    @job_location.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_location
      @job_location = JobLocation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_location_params
      params.require(:job_location).permit(:job_id, :location_id)
    end
end
