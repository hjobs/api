class AuthenticationController < ApplicationController
  # skip_before_action :authenticate_request

  def return_user
    if @current_user
      if @iam = 'employer'
        render json: { employer: @current_user, org: @current_user.org, jobs: @current_user.org.jobs, projects: @current_user.org.projects }
      else
        render json: { employee: @current_user, jobs: @current_user.jobs, projects: @current_user.projects }
      end
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  def authenticate
    logger.debug ['params[:iam]',params[:iam]]
    @command = AuthenticateUser.call(params[:iam], params[:email], params[:password])

    if @command.success?
      logger.debug "inside @command.success?, @command.reult/auth_token = " + @command.result
      if params[:iam] == 'employee'
        @employee = Employee.find_by(email: params[:email])
        render json: { employee: @employee, auth_token: @command.result}, status: :created, location: @employee
      elsif params[:iam] == 'employer'
        @employer = Employer.find_by email: params[:email]
        render json: { employer: @employer, org: @employer.org, auth_token: @command.result}, status: :created, location: @employer
      end

    else
      logger.debug "inside @command.success else, cannot log in"
      render json: { error: @command.errors }, status: :unauthorized
    end
  end
end
