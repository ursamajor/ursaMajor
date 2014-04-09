require "#{Rails.root}/lib/rules/rule"

class YamlRule < Rule
  @source = :yaml

  def source
    self.class.source
  end

  def initialize(name, entry)
    @name = name.to_sym
    @entry = entry
    @description = entry['description']
    @rule, @args = Rule.parse_entry @entry
  end

  def check(plan, args, flags=[])
    fail ArgumentError,
      "YAML rules should not take arguments, got #{args.inspect}" unless args.nil?
    @@current_rule = self.name.to_s
    @rule.check plan, @args, flags
  end
end
