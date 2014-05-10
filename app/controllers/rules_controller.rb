class RulesController < ApplicationController
  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html
      format.json { render 'index.json' }
    end
  end

  def display
    @rule = ClientRule.get(params[:rule])
    @courses = Course.tagged_with(@rule.name.to_s)
    respond_to do |format|
      format.html
      format.json { render :partial => "courses.json" }
    end
  end

  def search
    @rules = ClientRule.json #params[:major]
    respond_with @rules
  end

end
