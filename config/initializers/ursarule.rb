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
