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
      subresult = check_course plan, course, args
      result.courses_union(subresult.courses)
      result.pass = true if subresult.pass
      result.subresults << subresult
    end
    result
  end

  def check_course(plan, course, args)
    fail NotImplementedError, "<Rule '#{name}'>.check_course"
  end
  
end
