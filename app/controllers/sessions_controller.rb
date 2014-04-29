class SessionsController < Devise::SessionsController
  layout "no_header"

  before_action :landing, :only => :new

  def landing
    @landing_page = true
  end

end