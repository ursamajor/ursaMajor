class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :number
      t.boolean :pnp, default: false
      t.integer :units
      t.timestamps
    end
  end
end
