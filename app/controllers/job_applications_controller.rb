class JobApplicationsController < ApplicationController
  # skip_before_action :authenticate_request
  # , only: [:index, :show, :index, :show_job_type, :get_picked]

  # POST /apply
  def apply
    job = Job.find(params[:application][:job_id])
    unless job_application = EmployeeJob.find_by(:employee => @current_user, :job => job)
      @command = MailgunSender.call(@current_user[:email], @current_user[:name], job)
      job_application = EmployeeJob.new(:employee => @current_user, :job => job)
      unless @command.success? && job_application.save
        render @command.errors || job_application.errors, status: :unprocessable_entity
        return
      end
    end
    render json: { success: true }
  end

  
  private
    def application_params
      params.require(:application).permit(:name, :email, :job_id)
    end
end
