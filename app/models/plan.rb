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

  def check
    results = []
    Rule.all.keys.each do |key|
      next if Rule.base.include? key
      key = key.to_s
      result = {}
      rule = Rule.get(key)
      value = rule.check_print self, nil
      result["name"] = key
      result["description"] = rule.description
      result["result"] = value[0]
      result["courses"] = value[1].map { |course| course.name }
      if result["courses"] == []
        result["courses"] = ""
      end
      result["url"] = Rails.application.routes.url_helpers.display_rules_path(:rule => key)
      results << result
    end
    results
  end

end
