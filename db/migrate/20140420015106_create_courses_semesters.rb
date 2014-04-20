class CreateCoursesSemesters < ActiveRecord::Migration
  def change
    create_table :courses_semesters, id: false do |t|
      t.belongs_to :course
      t.belongs_to :plan
    end
  end
end
