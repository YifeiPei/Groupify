class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.integer :gender
      t.integer :age
      t.float :GPA
      t.integer :course_id
      t.integer :group_id

      t.timestamps
    end
  end
end
