class JobApplicationsController < ApplicationController
  # skip_before_action :authenticate_request
  # , only: [:index, :show, :index, :show_job_type, :get_picked]

  # POST /apply
  def apply
    job = Job.find(params[:application][:job_id])
    @command = MailgunSender.call(@current_user[:email], @current_user[:name], job)
    if @command.success?
      render json: { success: true }
    else
      render @command.errors
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name, :email)
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

end
