class AddGroupIdToScg < ActiveRecord::Migration
  def change
    add_column :scgs, :group_id, :integer
  end
end
