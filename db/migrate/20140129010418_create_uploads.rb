class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :username
      t.string :file
      t.string :file_id

      t.timestamps
    end
    add_index :uploads, :file_id, unique: true
  end
end
