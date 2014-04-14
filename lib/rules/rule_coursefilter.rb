require "#{Rails.root}/lib/rules/rule"
require "#{Rails.root}/lib/rules/result"

class CourseFilter < Rule
  @source = :course_filter

  def abstract?
    self.class == CourseFilter
  end

  def check(plan, args)
    result = Result.new self, false
    plan.courses.each do |course|
      subresult_boolean = check_course plan, course, args
      if subresult_boolean
        result.add_course course
        result.pass = true
      end
    end
    result
  end

  def check_course(plan, course, args)
    fail NotImplementedError, "<Rule '#{name}'>.check_course"
  end
  
end
