class PasswordsController < Devise::PasswordsController
  layout "no_header"

  before_action :landing

  def landing
    @landing_page = true
  end

end