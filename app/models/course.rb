class Course < ActiveRecord::Base

  attr_accessible :name, :number, :pnp, :units
  
  def pnp?
    pnp
  end

  def courses
    [self]
  end
  
end
