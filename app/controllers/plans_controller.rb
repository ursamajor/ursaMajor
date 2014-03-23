class PlansController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in
  before_filter :is_owner, :only => :show
  
  def index
    @plans = current_user.plans
  end

  def show
    @plan = Plan.find_by_id params[:id]
  end

  def create
    plan = Plan.new
    plan.name = params[:plan_name]
    plan.user = current_user
    plan.save
    redirect_to :back
  end

  def add_course
    plan = Plan.find_by_id params[:id]
    course = Course.find_by_name params[:course_name].upcase
    plan.add course if course
    redirect_to :back
  end

  protected

  def is_owner
    plan = Plan.find_by_id params[:id]
    if current_user != plan.user
      flash[:error] = "Error: You do not have permission to access"
      redirect_to root_path
      return
    end
    return true
  end

end
