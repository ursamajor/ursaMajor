require 'yaml'
require "#{Rails.root}/lib/rules/rule"
require "#{Rails.root}/lib/rules/rule_coursefilter"
require "#{Rails.root}/lib/rules/rule_logical"
require "#{Rails.root}/lib/rules/rule_course"
require "#{Rails.root}/lib/rules/rule_yaml"

data = YAML.load_file("#{Rails.root}/lib/rules/test-rules.yaml")
data['rules'].keys.each do |rule|
  Rule.add YamlRule.new rule, data['rules'][rule]
end

if ENV['TAG_ALL']
  all_courses = Plan.new
  Course.all.each do |course|
    plan = Plan.new
    plan.add course
    all_courses.add course
    Rule.all.keys.each do |rule|
      next if Rule.base.include? rule
      Rule.get(rule).check_print plan, nil
    end
  end
  Rule.all.keys.each do |rule|
    next if Rule.base.include? rule
    Rule.get(rule).check_print all_courses, nil
  end
end
