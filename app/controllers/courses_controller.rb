class CoursesController < ApplicationController

  def index
    @courses = Course.all
    plan = Plan.find_by_id session[:plan]
    @plan = []
    if plan
      plan.courses.each do |course|
        @plan << course
      end
    end
  end

  def add
    course = Course.find_by_id params[:id]
    plan = Plan.find_by_id session[:plan]
    plan.courses << course if not plan.courses.include? course
    redirect_to :back
  end

  def remove
    course = Course.find_by_id params[:id]
    plan = Plan.find_by_id session[:plan]
    plan.courses.delete(course) if plan.courses.include? course
    redirect_to :back
  end

end
