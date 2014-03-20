class PlansController < ApplicationController
  
  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find_by_id params[:id]
  end

  def select
    session[:plan] = params[:id].to_i
    redirect_to :back
  end

  def create
    plan = Plan.create(params[:plan])
    redirect_to :back
  end

end
