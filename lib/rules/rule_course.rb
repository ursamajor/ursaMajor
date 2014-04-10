require "#{Rails.root}/lib/rules/rule_coursefilter"

class CourseRegexRule < CourseFilter
  def check_course(plan, course, regex, flags=[], fulfilling_set)
    Regexp.new(regex, 'i').match(course.name)
  end
end
Rule.add(CourseRegexRule.new :course_regex)
Rule.add(CourseRegexRule.new :dept)

class CourseRule < CourseFilter
  def check_course(plan, course, name, flags=[], fulfilling_set)
    course.name.downcase == name.downcase
  end
end
Rule.add(CourseRule.new :course)

class PnpRule < CourseFilter
  def check_course(plan, course, name, flags=[], fulfilling_set)
    course.pnp?
  end
end
Rule.add(PnpRule.new :pnp)

class CourseNumberRangeRule < CourseFilter
  def check_course(plan, course, range, flags=[], fulfilling_set)
    min = range[0]
    max = range.length > 1 ? range[1] : Float::INFINITY
    course.number >= min && course.number <= max
  end
end
Rule.add(CourseNumberRangeRule.new :course_number_range)
