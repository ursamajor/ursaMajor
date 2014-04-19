class Plan < ActiveRecord::Base

  has_and_belongs_to_many :courses
  belongs_to :user

  validates :name, presence: true, uniqueness: { case_sensitive: true }
  
  def add(course)
    courses << course unless courses.include? course
  end

  def remove(course)
    courses.delete course if courses.include? course
  end

  def check(rule)
    result = Rule.get(rule).check_print self, nil
  end

end
