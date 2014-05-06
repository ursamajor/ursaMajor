class AddStartYearToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :start_year, :integer
  end
end
