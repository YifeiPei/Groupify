class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :email

      t.timestamps
    end
  end
end
