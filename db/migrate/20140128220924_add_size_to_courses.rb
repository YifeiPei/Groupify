class AddSizeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :size, :integer
  end
end
