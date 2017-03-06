class JobPeriodsController < ApplicationController
  before_action :set_job_period, only: [:show, :update, :destroy]

  # GET /job_periods
  def index
    @job_periods = JobPeriod.all

    render json: @job_periods
  end

  # GET /job_periods/1
  def show
    render json: @job_period
  end

  # POST /job_periods
  def create
    @job_period = JobPeriod.new(job_period_params)

    if @job_period.save
      render json: @job_period, status: :created, location: @job_period
    else
      render json: @job_period.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_periods/1
  def update
    if @job_period.update(job_period_params)
      render json: @job_period
    else
      render json: @job_period.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_periods/1
  def destroy
    @job_period.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_period
      @job_period = JobPeriod.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_period_params
      params.require(:job_period).permit(:job_id, :period_id)
    end
end
