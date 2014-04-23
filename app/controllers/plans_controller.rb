class PlansController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in
  before_filter :is_owner, :only => [:show, :add_course, :remove_course, :save, :check]
  
  def index
    @plans = current_user.plans
  end

  def show
    @plan = Plan.find_by_id params[:id]
    respond_to do |format|
      format.html
      format.json { render partial: 'show.json' }
    end
  end

  def create
    plan = Plan.new
    plan.name = params[:plan_name]
    plan.user = current_user
    Plan.semesters.each { |semester| plan.semesters.build name: semester.to_s }
    flash[:notice] = plan.save ? "Plan #{plan.name} successfully created" : "Plan name invalid"
    redirect_to :back
  end

  def save
    plan = Plan.find_by_id params[:id]
    semesters = params[:_json]
    plan.semesters.each do |semester|
      courses = []
      if params[semester.name]
        params[semester.name].each do |data|
          course = Course.find_by_id data['id']
          courses << course unless courses.include? course
        end
      else
        courses = []
      end
      semester.courses = courses
    end
    @result = plan.save ? true : false
    render partial: 'save.json'
  end

  def check
    plan = Plan.find_by_id params[:id]
    @results = plan.check
    respond_to do |format|
      format.json { respond_with @results }
    end
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

  private

  def plans_params
    params.require(:plan).permit(:name)
  end

end
