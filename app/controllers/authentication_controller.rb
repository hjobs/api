class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    logger.debug ['params[:iam]',params[:iam]]
    @command = AuthenticateUser.call(params[:iam], params[:email], params[:password])

    if @command.success?
      # logger.debug "inside @command.success?, @command.reult/auth_token = " + @command.result
      if params[:iam] == 'employee'
        @employee = Employee.find_by(email: params[:email])
        render json: { employee: @employee, auth_token: @command.result}, status: :created, location: @employee
      elsif params[:iam] == 'helper'
        @employer = Employer.find_by email: params[:email]
        render json: { employer: @employer, auth_token: @command.result}, status: :created, location: @employer
      end

    else
      render json: { error: @command.errors }, status: :unauthorized
    end
  end
end
