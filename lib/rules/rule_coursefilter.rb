require "#{Rails.root}/lib/rules/rule"

class CourseFilter < Rule
  @source = :course_filter

  def abstract?
    self.class == CourseFilter
  end

  def check(plan, args)
    plan.courses.each do |course|
      if check_course plan, course, args
        course.rule_list.add @@current_rule
        course.save
        return true 
      end
    end
    false
  end

  def check_course(plan, course, args)
    fail NotImplementedError, "<Rule '#{name}'>.check_course"
  end
  
end
