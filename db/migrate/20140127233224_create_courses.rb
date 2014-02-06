class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
  t.belongs_to :user
      t.string :name
      t.string :filelocation

      t.timestamps
    end
  end
end
