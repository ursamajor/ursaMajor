class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :rules

  def rules
    @rules = Rule.all
  end

end
