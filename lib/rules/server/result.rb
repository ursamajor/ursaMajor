class Result
  attr_accessor :rule, :courses, :pass, :subresults

  def initialize(rule, pass)
    @rule = rule
    @courses = []
    @pass = pass
    @subresults = []
  end

  def add_course(course)
    @courses << course unless @courses.include? course
  end

  def courses_union(result)
    @courses |= result.courses
  end

  def courses_intersect(result)
    @courses &= result.courses
  end

  def courses_subtract(result)
    @courses -= result.courses
  end

  def tag_courses
    # unless @rule.core?
    #   @courses.each { |course| course.rule_list.add @rule.name.to_s; course.save }
    #   @subresults.each { |result| result.tag_courses }
    # end
    @courses.each { |course| course.rule_list.add @rule.name.to_s; course.save }
  end

end