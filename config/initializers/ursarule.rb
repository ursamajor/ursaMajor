require 'yaml'
require "#{Rails.root}/lib/rule"
require "#{Rails.root}/lib/rule_coursefilter"
require "#{Rails.root}/lib/rule_logical"
require "#{Rails.root}/lib/rule_course"
require "#{Rails.root}/lib/rule_yaml"

data = YAML.load_file("#{Rails.root}/config/initializers/test-rules.yaml")
data['rules'].keys.each do |rule|
  Rule.add YamlRule.new rule, data['rules'][rule]
end