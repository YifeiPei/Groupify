class RenameGroupToScg < ActiveRecord::Migration
  def change
  rename_table :groups, :scgs
  end
end
