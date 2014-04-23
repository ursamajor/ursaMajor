class RulesController < ApplicationController
  respond_to :html, :json
  
  def index
  end

  def display
    @rule = Rule.get(params[:rule])
  end

  def search
    @rules = Rule.json
    respond_with @rules
  end

end
