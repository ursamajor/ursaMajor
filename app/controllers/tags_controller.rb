class TagsController < ApplicationController

  def tag_all
    if ENV['TAG_ALL'] == "true"
      all_courses = Plan.new
      Course.all.each do |course|
        plan = Plan.new
        plan.add course
        all_courses.add course
        Rule.all.keys.each do |rule|
          next if Rule.base.include? rule
          next if course.rule_list.include? rule
          Rule.get(rule).check_print plan, nil
        end
      end
      Rule.all.keys.each do |rule|
        next if Rule.base.include? rule
        Rule.get(rule).check_print all_courses, nil
      end
    end
    redirect_to root_path
  end

end