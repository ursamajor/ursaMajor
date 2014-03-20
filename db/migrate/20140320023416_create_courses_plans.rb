class CreateCoursesPlans < ActiveRecord::Migration
  def change
    create_table :courses_plans do |t|
      t.belongs_to :course
      t.belongs_to :plan
      t.timestamps
    end
  end
end
