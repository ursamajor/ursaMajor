require "#{Rails.root}/lib/rules/server/rule"
require "#{Rails.root}/lib/rules/server/result"

class AndRule < Rule
  def check(plan, entries)
    result = Result.new self, true
    Rule.parse_entries(entries).each do |rule, args|
      subresult = rule.check plan, args
      if result.rule.name == :not
        result.courses_subtract subresult
      else
        result.courses_union subresult
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
      result.courses_union subresult
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
      result.courses_union subresult
      result.pass = false if subresult.pass
      result.subresults << subresult
    end
    result
  end
end
Rule.add(NotRule.new :not)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SameCourseRule < CourseFilter
  def check_course(plan, course, entries)
    result = Rule.get(:and).check course, entries
    result.pass
  end
end
Rule.add(SameCourseRule.new :same_course)


# SeriesRule is obsolete

class SameDeptRule < Rule
  def check(plan, entry)
    rule, args = Rule.parse_entry entry

    result = Result.new self, false
    plan.courses.each do |course1| 
      dept_plan = Semester.new
      plan_dept_name = course1.dept
      plan.courses.each do |course2|
        dept_plan.add course2 if course2.dept == plan_dept_name
      end
      subresult = rule.check dept_plan, args
      if subresult.pass
        result.pass = true
        result.courses_union subresult
        result.subresults << subresult
      end
    end
    result
  end
end
Rule.add(SameDeptRule.new :same_dept)
