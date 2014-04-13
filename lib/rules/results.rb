class Result
  attr_accessor :rule, :fulfilling_set, :pass, :subrules

  def initialize(rule)
    @rule = rule
    @fulfilling_set = []
    @pass = false
    @subrules = []
  end

  def union(set)
  end

  def intersect(set)
  end

  def subtract(set)
  end

end