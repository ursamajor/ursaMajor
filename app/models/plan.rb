class Plan < ActiveRecord::Base

  acts_as_taggable_on :rules
  has_many :semesters
  has_many :courses, through: :semesters
  belongs_to :user

  validates :name, presence: true

  @@semesters = [:backpack, :fall1, :fall2, :fall3, :fall4, :spring1, :spring2, :spring3, :spring4, :summer1, :summer2, :summer3, :summer4]

  def self.semesters
    @@semesters
  end

  def self.create_demo
    plan = Plan.new :name => "Demo Plan"
    Plan.semesters.each { |semester| plan.semesters.build name: semester.to_s }
    plan.start_year = 2013
    plan.save
    plan
  end

  def check
    results = []
    Rule.all.values.each do |rule|
      next if rule.core?
      result = {}
      value = rule.check_print self, nil
      result["name"] = rule.name.to_s
      result["description"] = rule.description
      result["result"] = value[0]
      result["courses"] = value[1].map { |course| course.name }
      if result["courses"] == []
        result["courses"] = ""
      end
      result["url"] = Rails.application.routes.url_helpers.display_rules_path(:rule => rule.name)
      results << result
    end
    results
  end

  def get(name)
    semesters.each do |semester|
      return semester.courses if semester.name == name.to_s
    end
  end

end
