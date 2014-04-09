require "#{Rails.root}/lib/rules/rule"

class CourseFilter < Rule
  @source = :course_filter

  def abstract?
    self.class == CourseFilter
  end

  def check(plan, args, flags=[])
    plan.courses.each do |course|
      if check_course plan, course, args, flags
        course.rule_list.add @@current_rule
        course.rule_list.add @@top_level_rule
        course.save unless flags.include? "NOT"
        return true 
      end
    end
    false
  end

  def check_course(plan, course, args, flags=[])
    fail NotImplementedError, "<Rule '#{name}'>.check_course"
  end
  
end
