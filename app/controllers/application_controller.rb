class ApplicationController < ActionController::Base

  protect_from_forgery

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
