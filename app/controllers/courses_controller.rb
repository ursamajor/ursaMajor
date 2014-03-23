class CoursesController < ApplicationController
  respond_to :html, :json

  def index
    @courses = Course.all
    query = session[:search_query] = params[:search_query]

    if ! [nil, ""].include?(query)
      @courses = Course.match_regex(query)
    end
  end

end
