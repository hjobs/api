class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    logger.debug "session"
    logger.debug session.to_json
    # if session[:user_id] && @user = Employee.find_by_id(session[:user_id])
    #   # Means our user is signed in. Add the authorization to the user
    #   @user.add_provider(auth_hash)
    #   @command = OauthUser.call("employee", @user.id)
    # else
      # Log him in or sign him up
      @auth = Auth.find_or_create(auth_hash)
      @user = @auth.authable

      # Create JWT
      @command = OauthUser.call("employee", @auth.authable.id)

      # # Create the session
      # session[:user_id] = @user.id
    # end

    unless @command.success?
      @auth.authable.destroy
      render :json => @command.errors
      return
    end

    url = request.env['omniauth.origin']
    url = "https://www.hjobs.hk" if !url
    query_prefix = url.include?('?') ? "&" : "?"
    applying = url.include?('job=') ? "&applying=true" : ""
    employee_string = EmployeeSerializer.new(@user).to_json.gsub("#", "%23")
    logger.debug "employee_string"
    logger.debug employee_string
    url += query_prefix + "user=" + employee_string + "&auth_token=" + @command.result + applying
    redirect_to url

    logger.debug auth_hash
  end

  def failure
    render json: true
  end

  def destroy
    if !@current_user.respond_to?(:last_name) 
      render status: :unauthorized
      return
    end
    # user.active = false
    if @current_user
      session[:user_id] = nil
      render :json => @current_user
    else
      render status: :unprocessable_entity
    end
  end
end
