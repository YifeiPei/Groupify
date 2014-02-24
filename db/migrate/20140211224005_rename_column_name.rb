class RenameColumnName < ActiveRecord::Migration
  def change
  rename_column :students, :name, :first_name
  end
end
