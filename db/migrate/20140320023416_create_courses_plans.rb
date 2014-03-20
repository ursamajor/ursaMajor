class CreateCoursesPlans < ActiveRecord::Migration
  def change
    create_table :courses_plans, id: false do |t|
      t.belongs_to :course
      t.belongs_to :plan
    end
  end
end
