class UsersController < ApplicationController
  
  def new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render :root
    else
      @message = 'Invalid Entry! Please try again.'
      # redirect_to '/signup'
      render :new
    end
  end   

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end