class DropCoursesPlansTable < ActiveRecord::Migration
  def change
    drop_table :courses_plans
  end
end
