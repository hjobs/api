class ApplicationController < ActionController::API
  before_action :authenticate_request, :set_global_variables, :get_current_user
  attr_reader :current_user, :iam

  def set_global_variables
    # @variable = "value"
  end

  private

  def authenticate_request
    authorized = AuthorizeApiRequest.call(request.headers, params[:iam]).result
    render json: { error: 'Not Authorized' }, status: 401 unless authorized
  end

  def get_current_user
    @iam = params[:iam]
    @current_user = GetCurrentUser.call(request.headers, params[:iam]).result
    logger.debug @current_user
  end

end
