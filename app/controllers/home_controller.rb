class HomeController < ApplicationController
  respond_to :html, :json
  
  def index
  end

  def demo
    @plan = session[:demo_id] ? Plan.find_by(id: session[:demo_id]) : Plan.create_demo 
    @plan ||= Plan.create_demo 
    session[:demo_id] = @plan.id
    respond_to do |format|
      format.html
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
    @result = plan.save ? true : false
    render partial: 'plans/save.json'
  end

end
