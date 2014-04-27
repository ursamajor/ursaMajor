require "#{Rails.root}/lib/rules/rule"
require "#{Rails.root}/lib/rules/result"

class YamlRule < Rule
  @source = :yaml

  def source
    self.class.source
  end

  def initialize(name, entry)
    @name = name.to_sym
    @entry = entry
    @description = entry['description']
    @hidden = entry['hidden'] || false
    @num_courses = YamlRule.get_num_courses(entry) || 1
    @num_units = YamlRule.get_num_units(entry) || 0
    @subrules = entry['subrules'] || []
    @rule, @args = Rule.parse_entry @entry
  end

  def self.get_num_courses(entry)
    if entry['rule'] == 'count_courses'
      entry['args']['min'] || 1
    end
  end

  def self.get_num_units(entry)
    if entry['rule'] == 'units'
      entry['args']['min'] || 0
    end
  end

  def check(plan, args)
    fail ArgumentError,
      "YAML rules should not take arguments, got #{args.inspect}" unless args.nil?
    result = Result.new self, false
    subresult = @rule.check plan, @args
    result.courses = subresult.courses
    result.pass = subresult.pass
    result.subresults << subresult
    result
  end
end
