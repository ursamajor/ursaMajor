class ChangeCoursesSemestersField < ActiveRecord::Migration
  def change
    rename_column :courses_semesters, :plan_id, :semester_id
  end
end
