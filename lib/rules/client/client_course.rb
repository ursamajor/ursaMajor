require "#{Rails.root}/lib/rules/server/rule_coursefilter"
require "#{Rails.root}/lib/rules/server/result"

class CourseRegexRule < CourseFilter
  def check_course(plan, course, regex)
    Regexp.new(regex, 'i').match(course.name)
  end
end
Rule.add(CourseRegexRule.new :course_regex)
Rule.add(CourseRegexRule.new :dept)

class CourseRule < CourseFilter
  def check_course(plan, course, name)
    course.name.downcase == name.downcase
  end
end
Rule.add(CourseRule.new :course)

class PnpRule < CourseFilter
  def check_course(plan, course, name)
    course.pnp?
  end
end
Rule.add(PnpRule.new :pnp)

###  OBSOLETE
# class CourseNumberRangeRule < CourseFilter  
#   def check_course(plan, course, range)
#     min = range[0]
#     max = range.length > 1 ? range[1] : Float::INFINITY
#     course.number >= min && course.number <= max
#   end
# end
# Rule.add(CourseNumberRangeRule.new :course_number_range)

class CourseNumberRule < CourseFilter
  def check_course(plan, course, entry)
    fail ArgumentError unless entry['min'] || entry['max']
    min = entry['min'] || 0
    max = entry['max'] || Float::INFINITY
    course.number >= min && course.number <= max
  end
end
Rule.add(CourseNumberRule.new :course_number)

class UnitsRule < Rule
  def check(plan, entry)
    fail ArgumentError unless entry['min'] || entry['max']
    min = entry['min'] || 0
    max = entry['max'] || Float::INFINITY
    rule, args = Rule.parse_entry entry

    subresult = rule.check plan, args
    total = 0
    subresult.courses.each { |course| total += course.units }
    result_boolean = total >= min && total <= max
    result = Result.new self, result_boolean
    result.courses = subresult.courses
    result.subresults << subresult
    result
  end
end
Rule.add(UnitsRule.new :units)

class NumCoursesRule < Rule
  def check(plan, entry)
    min = entry['min'] || 1
    max = entry['max'] || Float::INFINITY
    rule, args = Rule.parse_entry entry

    subresult = rule.check plan, args
    total = subresult.courses.length
    result_boolean = total >= min && total <= max
    result = Result.new self, result_boolean
    result.courses = subresult.courses
    result.subresults << subresult
    result
  end
end
Rule.add(NumCoursesRule.new :count_courses)
