class LogsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_log, only: [:show, :update, :destroy]

  # GET /logs
  def index
    @logs = Log.all

    render json: @logs
  end

  # GET /logs/1
  def show
    render json: @log
  end

  # POST /logs
  def create
    @log = Log.new(log_params)
    if (@iam == 'employee')
      Log.employee = @current_user
    elsif (@iam == 'employer')
      Log.employer = @current_user
    end

    if @log.save
      render json: @log, status: :created
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1
  def update
    if @log.update(log_params)
      render json: @log
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logs/1
  def destroy
    @log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def log_params
      params.require(:log).permit(:name, :action, :job_id, :employee_id, :employer_id, :org_id, :job_type_id, :component, :page, :target)
    end
end
