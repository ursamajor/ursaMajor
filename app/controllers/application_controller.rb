class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :rules, :landing_page
  after_filter :set_csrf_cookie_for_ng
  def landing_page
    @landing_page = false
  end

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

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
