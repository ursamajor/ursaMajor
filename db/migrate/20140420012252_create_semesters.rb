class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.belongs_to :plan
      t.string :name
      t.timestamps
    end
  end
end
