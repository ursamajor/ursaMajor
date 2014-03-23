class RulesController < ApplicationController
  respond_to :html, :json
  
  def index
    @rules = Rule.all
  end

end
