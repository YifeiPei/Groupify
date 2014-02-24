class CreateScgs < ActiveRecord::Migration
  def change
    create_table :scgs do |t|
      t.integer :size
      t.integer :student_id
      t.integer :course_id

      t.timestamps
    end
  end
end
