class AddPasswordToStudents < ActiveRecord::Migration
  def change
    add_column :students, :password, :string
    add_column :students, :salt, :string
  end
end
