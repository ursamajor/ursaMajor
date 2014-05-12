class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :rules
  after_action :set_csrf_cookie_for_ng

  protected

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = '*'
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

  def set_cache_buster
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age='0', pre-check='0', post-check='0'"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
