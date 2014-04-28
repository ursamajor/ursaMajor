require "#{Rails.root}/lib/rules/server/rule"

class ClientRule < Rule
  attr_accessor :num_courses, :num_units, :operator, :subrules, :course

  @source = :client
  @rules = {}

  class << self
    attr_accessor :source, :rules
    alias_method :all, :rules
    def source
      @source || superclass.source
    end
  end

  def initialize(name, entry={})
    @name = name.to_sym
    entries = entry['args']
    @description = entry['description']
    @hidden = entry['hidden'] || false
    @operator = get_operator(entry)
    @num_courses = get_num_courses(entry)
    @num_units = get_num_units(entry)
    @subrules = []
    @course = nil
    parse_entries entries if variable?
  end

  def self.course_rule(name)
    rule = ClientRule.new(name)
    rule.hidden = true
    rule.num_courses = 1
    rule
  end

  def json
    rule = {}
    rule["name"] = @name.to_s
    rule["description"] = @description
    rule["operator"] = @operator
    rule["numCourses"] = @num_courses
    rule["numUnits"] = @num_units
    rule["course"] = @course
    rule["subrules"] = []
    @subrules.each { |subrule| rule["subrules"] << subrule.json }
    rule["url"] = Rails.application.routes.url_helpers.display_rules_path(:rule => @name)
    rule
  end

  def get_operator(entry)
    rule = entry['rule']
    if rule == 'AND'
      rule
    elsif rule == 'OR'
      rule if @hidden
    else
      nil
    end
  end

  def get_num_courses(entry)
    if entry['rule'] == 'count_courses'
      entry['args']['min'] || 1
    else
      1
    end
  end

  def get_num_units(entry)
    if entry['rule'] == 'units'
      entry['args']['min'] || 0
    else
      0
    end
  end

  def variable?
    @operator == "AND" || @operator == "OR"
  end

  def parse_entry(entry)
    if entry.include? 'rule'
      name = entry['rule']
      @subrules << ClientRule.get(name)
    elsif entry.include? 'course'
      name = entry['course']
      @subrules << ClientRule.course_rule(name)
    elsif entry.length == 1
        begin 
          name = entry.keys[0]
        rescue
          puts entry
        end
    else
      fail ArgumentError, "invalid rule entry: #{entry}"
    end
  end

  def parse_entries(entries)
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