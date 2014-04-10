class RulesController < ApplicationController
  respond_to :html, :json
  
  def index
    @rules = Rule.all
  end

  def display
    @rule = Rule.get(params[:rule])
  end

end
