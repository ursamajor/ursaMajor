class CoursesController < ApplicationController
  respond_to :html, :json
  before_action :cors_set_access_control_headers, :only => [:tagged_courses]

  def index
    @courses = Course.order 'name ASC'
    # query = session[:search_query] = params[:search_query]

    # if ! [nil, ""].include? query
    #   query = "%"+query.upcase+"%"
    #   @courses = Course.search_query query
    # end
    respond_to do |format|
      format.html
      format.json { render 'index.json' }
    end
  end

  def show
    @course = Course.find_by id: params[:id]
  end

  def search
    unless params[:course] == 'all' && ENV['TAG_ALL'] == "true"
      redirect_to landing_path and return
      # query = "%"+params[:course].upcase+"%"
      # @courses = @courses.where("upper(name) like ?", query)
    end
    @courses = Course.order 'name ASC'
    render :partial => "courses/all.json"
  end

  def all
    @courses = Course.all
  end

  def tagged_courses
    respond_to do |format|
      format.json { render 'tagged_courses.json' }
    end
  end

  private

  def courses_params
    params.require(:course).permit(:name, :number, :pnp, :units)
  end

end
