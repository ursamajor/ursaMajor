class SessionsController < Devise::SessionsController

  before_action :landing, :only => :new

  def landing
    @landing_page = true
  end

end