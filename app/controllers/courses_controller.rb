class CoursesController < ApplicationController
  respond_to :html, :json

  def index
    @courses = Course.order 'name ASC'
    query = session[:search_query] = params[:search_query]

    if ! [nil, ""].include? query
      query = "%"+query.upcase+"%"
      @courses = Course.search_query query
    end
  end

  def show
    @course = Course.find_by_id params[:id]
  end

  def all
    @courses = Course.order 'name ASC'
  end

end
