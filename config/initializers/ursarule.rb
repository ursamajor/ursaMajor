require 'yaml'
require "#{Rails.root}/lib/rules/server/rule"
require "#{Rails.root}/lib/rules/server/rule_coursefilter"
require "#{Rails.root}/lib/rules/server/rule_logical"
require "#{Rails.root}/lib/rules/server/rule_course"
require "#{Rails.root}/lib/rules/server/rule_yaml"
require "#{Rails.root}/lib/rules/client/client_rule"

data = YAML.load_file("#{Rails.root}/lib/rules/yaml/test-rules.yaml")
data['rules'].keys.each do |rule|
  Rule.add YamlRule.new rule, data['rules'][rule]
  ClientRule.add ClientRule.new rule, data['rules'][rule]
end
