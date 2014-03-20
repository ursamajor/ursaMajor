class Plan < ActiveRecord::Base

  attr_accessible :name
  
  def add(course)
    courses << course unless @courses.include? course
  end

end
