class Rule
  attr_accessor :name
  attr_accessor :description

  @@current_rule = Rule.name
  @source = :raw
  @rules = {}

  class << self
    attr_accessor :source, :rules
    alias_method :all, :rules
    def source
      @source || superclass.source
    end
  end

  def initialize(name = nil, description = nil)
    @name = name
    @description = description
    fail 'abstract' if abstract?
  end

  def self.current_rule
    @@current_rule
  end

  def abstract?
    self.class == Rule
  end

  def inspect
    if name then "Rule.get(#{name.inspect})"
    else super
    end
  end
  alias_method :to_s, :inspect

  def self.check_type(desc, obj, expected_class)
    unless obj.is_a? expected_class
      fail TypeError,
        "#{desc}: expected #{expected_class} but got #{obj.class} #{obj.inspect}"
    end
  end

  def self.get(name)
    name = name.downcase.to_sym if name.is_a? String
    check_type 'name', name, Symbol
    fail "rule #{name.inspect} does not exist" unless @rules.include? name
    @rules[name]
  end

  def self.add(rule)
    check_type 'rule', rule, Rule
    check_type 'rule.name', rule.name, Symbol
    @rules[rule.name] = rule
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
    [Rule.get(name), args]
  end

  def self.parse_entries(entries)
    entries.map { |entry| parse_entry entry }
  end

  def check(plan, args)
    fail NotImplementedError, "<Rule '#{name}'>.check"
  end

  def check_print(plan, args)
    result = check plan, args
    "The plan #{result ? 'PASSES' : 'FAILS'} rule #{name}."
  end

end
