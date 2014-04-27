class PasswordsController < Devise::PasswordsController

  before_action :landing

  def landing
    @landing_page = true
  end

end