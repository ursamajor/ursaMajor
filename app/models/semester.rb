class Semester < ActiveRecord::Base

  has_and_belongs_to_many :courses
  belongs_to :plan

  def add(course)
    courses << course unless courses.include? course
  end

  def remove(course)
    courses.delete course if courses.include? course
  end

end
