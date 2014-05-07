class HomeController < ApplicationController
  respond_to :html, :json

  before_action :set_cache_buster, :only => [:demo]
  
  def index
    if signed_in?
      redirect_to demo_path and return
    else
      @user = User.new
      render :layout => "landing"
    end
  end

  def contact
  end

  def demo
    @plan = session[:demo_id] ? Plan.find_by(id: session[:demo_id]) : Plan.create_demo 
    @plan ||= Plan.create_demo 
    @demo = true
    session[:demo_id] = @plan.id
    respond_to do |format|
      format.html { render 'plans/show.html' }
      format.json { render partial: 'plans/show.json' }
    end
  end

  def demo_check
    plan = Plan.find_by id: session[:demo_id]
    @results = plan.check
    respond_to do |format|
      format.json { respond_with @results }
    end
  end

  def demo_save
    plan = Plan.find_by id: session[:demo_id]
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
    render partial: 'plans/save.json'
  end

end
