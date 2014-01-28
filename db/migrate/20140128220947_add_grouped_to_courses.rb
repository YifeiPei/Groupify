class AddGroupedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :grouped, :boolean
  end
end
