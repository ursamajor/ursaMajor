class Course < ActiveRecord::Base

  attr_accessible :name, :number, :pnp, :units
  has_and_belongs_to_many :plans

  scope :match_regex, lambda { |regex| where("name REGEXP ?", regex) }

  def pnp?
    pnp
  end

  def courses
    [self]
  end
  
end
