class AddConfirmedToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :confirmed, :boolean
  end
end
