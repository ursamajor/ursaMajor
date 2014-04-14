require "#{Rails.root}/lib/rules/rule"
require "#{Rails.root}/lib/rules/result"

class AndRule < Rule
  def check(plan, entries)
    result = Result.new self, true
    Rule.parse_entries(entries).each do |rule, args|
      subresult = rule.check plan, args
      if result.rule.name == :not
        result.courses_subtract(subresult)
      else
        result.courses_intersect(subresult)
      end
      result.pass = false unless subresult.pass
      result.subresults << subresult
    end
    result
  end
end
Rule.add(AndRule.new :and)

class OrRule < Rule
  def check(plan, entries)
    result = Result.new self, false
    Rule.parse_entries(entries).each do |rule, args|
      subresult = rule.check plan, args
      result.courses_union(subresult)
      result.pass = true if subresult.pass
      result.subresults << subresult
    end
    result
  end
end
Rule.add(OrRule.new :or)

class NotRule < Rule
  def check(plan, entries)
    result = Result.new self, true
    Rule.parse_entries(entries).each do |rule, args|
      subresult = rule.check plan, args
      result.courses_union(subresult)
      result.pass = false if subresult.pass
      result.subresults << subresult
    end
    result
  end
end
Rule.add(NotRule.new :not)

class UnitsRule < Rule
  def check(plan, entry)
    fail ArgumentError unless entry['min'] || entry['max']
    min = entry['min'] || 0
    max = entry['max'] || Float::INFINITY
    rule, args = Rule.parse_entry entry['rule']
    subresult = rule.check plan, args
    total = 0
    subresult.courses.each { |course| total += course.units }
    result_boolean = total >= min && total <= max
    Result.new self, result_boolean
  end
end
Rule.add(UnitsRule.new :units)

class CoursesRule < Rule
  def check(plan, entry)
    fail ArgumentError unless entry['min'] || entry['max']
    min = entry['min'] || 0
    max = entry['max'] || Float::INFINITY
    rule, args = Rule.parse_entry entry['rule']
    subresult = rule.check plan, args
    total = subresult.courses.length
    result_boolean = total >= min && total <= max
    Result.new self, result_boolean
  end
end
Rule.add(UnitsRule.new :courses)

class SeriesRule < Rule
  def check(plan, entry)
    fail ArgumentError unless entry['dept']
    rule, args = Rule.parse_entry entry['rule']

    result = Result.new self, false
    plan.courses.each do |course1| 
      dept_plan = Plan.new
      plan_dept_name = course1.dept
      plan.courses.each do |course2|
        dept_plan.add course2 if course2.dept == plan_dept_name
      end
      result.pass = true if rule.check dept_plan, args
    end
    result
  end
end
Rule.add(SeriesRule.new :series)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SameCourseRule < CourseFilter
  def check_course(plan, course, entries)
    Rule.get(:and).check course, entries
  end
end
Rule.add(SameCourseRule.new :same_course)
