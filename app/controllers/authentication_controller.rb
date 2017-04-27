class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:authenticate]

  def return_user
    if @current_user
      if @iam == 'employer'
        jobs = @current_user.org.jobs.sort_by{|x| x.created_at}.reverse
        render json: { employer: @current_user, org: @current_user.org, jobs: jobs}
      else
        render json: { employee: @current_user, jobs: @current_user.jobs}
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
      logger.debug Employer.find_by email: params[:email]
      if params[:iam] == 'employee'
        @employee = Employee.find_by(email: params[:email])
        render json: { employee: @employee, auth_token: @command.result}, status: :created
      elsif params[:iam] == 'employer'
        @me = Employer.find_by email: params[:email]
        render json: { me: @me, org: @me.org, employers: @me.org.employers, auth_token: @command.result}, status: :created
      end

    else
      logger.debug "inside @command.success else, cannot log in"
      render json: { error: @command.errors }, status: :unauthorized
    end
  end
end
