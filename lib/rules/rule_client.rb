require "#{Rails.root}/lib/rules/rule"

class ClientRule < Rule
  attr_accessor :num_courses, :num_units, :operator, :subrules

  @source = :client
  @rules = {}

  class << self
    attr_accessor :rules
    alias_method :all, :rules
  end

  def initialize(name, entry)
    @name = name.to_sym
    @entry = entry
    @description = entry['description']
    @hidden = entry['hidden'] || false
    @operator = ClientRule.get_operator(entry)
    @num_courses = ClientRule.get_num_courses(entry)
    @num_units = ClientRule.get_num_units(entry)
    @subrules = []
    ClientRule.parse_entry @entry
  end

  def json
    rule = {}
    rule["name"] = @name.to_s
    rule["description"] = @description
    rule["operator"] = @operator
    rule["numCourses"] = @num_courses
    rule["numUnits"] = @num_units
    rule["subrules"] = []
    @subrules.each { |subrule| rule["subrules"] << subrule.json }
    rule["url"] = Rails.application.routes.url_helpers.display_rules_path(:rule => @name)
    rule
  end

  def self.get_operator(entry)
    rule = entry['rule']
    if rule == 'AND' || rule == 'OR'
      rule
    else
      false
    end
  end

  def self.get_num_courses(entry)
    if entry['rule'] == 'count_courses'
      entry['args']['min'] || 1
    else
      1
    end
  end

  def self.get_num_units(entry)
    if entry['rule'] == 'units'
      entry['args']['min'] || 0
    else
      0
    end
  end

  def self.parse_entry(entry, allow_implicit = true)
    if entry.is_a? String
      name = entry
      args = nil
    elsif entry.include? 'rule'
      name = entry['rule']
      args = entry.include?('args') ? entry['args'] : nil
    elsif allow_implicit && entry.length == 1
        begin 
          name = entry.keys[0]
          args = entry.values[0]
        rescue
          puts entry
        end
    else
      fail ArgumentError, "invalid rule entry: #{entry}"
    end
    [ClientRule.get(name), args]
  end

  def self.parse_entries(entries)
    entries.map { |entry| parse_entry entry }
  end

  def self.json
    rules = []
    self.all.values.each do |rule|
      next if rule.hidden?
      rules << rule.json
    end
    rules
  end

end