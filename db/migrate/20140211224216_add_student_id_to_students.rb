class AddStudentIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_id, :string
  end
end
