class Plan < ActiveRecord::Base

  attr_accessible :name
  has_and_belongs_to_many :courses
  
  def add(course)
    courses << course unless courses.include? course
  end

end
