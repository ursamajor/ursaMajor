class UsersController < ApplicationController
  respond_to :html, :json
  
  def landing_create
    user = User.new user_params
    if user.save
      current_user = user
      redirect_to '/demo', notice: "Welcome! You have signed up successfully."
    else
      flash[:warning] = "Invalid email or password combination"
      redirect_to '/landing'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
