class Course < ActiveRecord::Base

  attr_accessible :name, :number, :pnp, :units
  has_and_belongs_to_many :plans

  def pnp?
    pnp
  end

  def courses
    [self]
  end
  
end
