class ApplicationController < ActionController::API
  # before_action :authenticate_request, :set_global_variables
  before_action :set_global_variables
  attr_reader :current_user

  def set_global_variables
    # @variable = "value"
    @authToken = request.headers
  end

  private

  def authenticate_request
    @iam = params[:iam]
    @current_user = AuthorizeApiRequest.call(request.headers,@iam).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

end
