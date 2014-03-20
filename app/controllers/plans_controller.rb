class PlansController < ApplicationController
  
  def index
    @plans = Plan.all
    add_course params[:course] if params[:course]
  end

  def show
    @plan = Plan.find_by_id params[:id]
  end

  def select
    session[:plan] = params[:id].to_i
    redirect_to :back
  end

  def create
    plan = Plan.create params[:plan]
    redirect_to :back
  end

  def add
    plan = Plan.find_by_id params[:id]
    course = Course.find_by_name params[:course]
    plan.add course if course
    redirect_to :back
  end

end
