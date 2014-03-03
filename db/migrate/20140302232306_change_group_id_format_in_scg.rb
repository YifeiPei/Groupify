class ChangeGroupIdFormatInScg < ActiveRecord::Migration
  def change
   change_column :scgs, :group_id,  :integer
  end
end
