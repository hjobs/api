class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    if session[:user_id] && Employee.find(session[:user_id])
      # Means our user is signed in. Add the authorization to the user
      user = Employee.find(session[:user_id])
      user.add_provider(auth_hash)

      render :json => user
    else
      # Log him in or sign him up
      auth = Auth.find_or_create(auth_hash)

      # Create the session
      session[:user_id] = auth.authable.id

      render :json => auth.authable
    end
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
