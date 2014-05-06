class AddMajorFieldToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :major, :string, default: "University"
  end
end
