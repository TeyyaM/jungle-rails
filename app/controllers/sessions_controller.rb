class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
    if user
      # Save the user id inside the browser cookie.
      session[:user_id] = user.id
      redirect_to '/'
    else
      @message = 'Invalid email or password! Please try again.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    render :new
  end
end
