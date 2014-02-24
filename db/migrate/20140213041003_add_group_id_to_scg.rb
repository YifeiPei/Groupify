class AddGroupIdToScg < ActiveRecord::Migration
  def change
    add_column :scgs, :group_id, :string
  end
end
