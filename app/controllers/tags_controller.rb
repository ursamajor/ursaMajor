class TagsController < ApplicationController

  def tag
    if ENV['TAG_ALL'] == "true"
      rule = params[:rule]
      all_courses = Semester.new
      all_courses.courses = Course.all
      Rule.get(rule).check_print all_courses, nil
    end
    redirect_to root_path
  end

  def tag_all
    if ENV['TAG_ALL'] == "true"
      all_courses = Semester.new
      all_courses.courses = Course.all
      Rule.all.values.each do |rule|
        next if rule.hidden?
        rule.check_print all_courses, nil
      end
    end
    redirect_to root_path
  end

end