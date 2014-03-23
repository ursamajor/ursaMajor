class Course < ActiveRecord::Base

  attr_accessible :name, :number, :pnp, :units
  has_and_belongs_to_many :plans

  scope :search_query, lambda { |query| where("name LIKE ?", query) }

  def pnp?
    pnp
  end

  def courses
    [self]
  end
  
end
