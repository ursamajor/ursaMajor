class PlansController < ApplicationController
  respond_to :html, :json
  before_action :signed_in
  before_action :is_owner, :except => [:index, :create]
  before_action :set_cache_buster, :only => [:show]
  
  def index
    @plans = current_user.plans
  end

  def show
    @plan = Plan.find_by id: params[:id]
    @demo = false
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

  def update
    @plan = Plan.find_by id: params[:id]

    respond_to do |format|
      if @plan.update_attributes plans_params
        format.json { respond_with_bip(@plan) }
      else
        format.json { respond_with_bip(@plan) }
      end
    end
  end

  def destroy
    plan = Plan.find_by id: params[:id]
    plan.destroy
    redirect_to plans_path, notice: "#{plan.name} was deleted."
  end

  def save
    plan = Plan.find_by id: params[:id]
    semesters = params[:_json]
    plan.semesters.each do |semester|
      courses = []
      if params[semester.name]
        params[semester.name].each do |data|
          course = Course.find_by id: data['id']
          courses << course unless courses.include? course
        end
      else
        courses = []
      end
      semester.courses = courses
    end
    plan.start_year = params[:startYear]
    plan.major = params[:major]
    @result = plan.save ? true : false
    render partial: 'save.json'
  end

  def check
    plan = Plan.find_by id: params[:id]
    @results = plan.check
    respond_to do |format|
      format.json { respond_with @results }
    end
  end

  protected

  def is_owner
    plan = Plan.find_by id: params[:id]
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
