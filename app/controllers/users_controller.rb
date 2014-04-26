class UsersController < ApplicationController
  respond_to :html, :json
  
  def landing_create
    user = User.new user_params
    if user.save
      current_user = user
      redirect_to home_demo_path
    else
      redirect_to '/landing'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
