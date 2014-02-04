class CreateSortConfigs < ActiveRecord::Migration
  def change
    create_table :sort_configs do |t|
      t.integer :course_id
      t.integer :algorithm
      t.boolean :age
      t.boolean :gpa
      t.boolean :degree

      t.timestamps
    end
  end
end
