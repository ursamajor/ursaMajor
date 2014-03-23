class Plan < ActiveRecord::Base

  attr_accessible :name
  has_and_belongs_to_many :courses
  belongs_to :user
  
  def add(course)
    courses << course unless courses.include? course
  end

  def remove(course)
    courses.delete course if courses.include? course
  end

end
