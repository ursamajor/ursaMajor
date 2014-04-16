class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :rules

  def rules
    @rules = Rule.all
  end

  def signed_in
    if not user_signed_in?
      flash[:error] = "Error: Not signed in"
      redirect_to new_user_session_path
      return
    end
    return true
  end

end
