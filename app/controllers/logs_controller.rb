class LogsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
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
    logger.debug 'going to log @iam and then iam'
    logger.debug @iam
    logger.debug iam
    if (@current_user)
      if (@iam == 'employee')
        @log.employee = @current_user
      elsif (@iam == 'employer')
        @log.employer = @current_user
      end
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
      params.require(:log).permit(:name, :action, :job_id, :employee_id, :employer_id, :org_id, :job_type_id, :component, :page, :target, :ad_id)
    end
end
