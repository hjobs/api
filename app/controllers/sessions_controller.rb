class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    if session[:user_id] && !Employee.find(session[:user_id])
      # Means our user is signed in. Add the authorization to the user
      @user = Employee.find(session[:user_id])
      @user.add_provider(auth_hash)
      @command = AuthenticateUser.call("employee", @user.id, nil)
    else
      # Log him in or sign him up
      @auth = Auth.find_or_create(auth_hash)
      @user = @auth.authable

      # Create JWT
      @command = AuthenticateUser.call("employee", @auth.authable.id, nil)

      # Create the session
      session[:user_id] = @auth.authable.id
    end

    unless @command.success?
      @auth.authable.destroy
      render :json => @command.errors
      return
    end

    url = request.env['omniauth.origin']
    url = "http://localhost:3000" if !url
    query_prefix = url.include?('?') ? "&" : "?"
    applying = url.include?('job=') ? "&applying=true" : ""
    url += query_prefix + "user=" + EmployeeSerializer.new(@user).to_json + "&auth_token=" + @command.result + applying
    redirect_to url
  end

  def failure
    render json: true
  end

  def destroy
    user = Employee.find(session[:user_id])
    session[:user_id] = nil
    render :json => user
  end
end
