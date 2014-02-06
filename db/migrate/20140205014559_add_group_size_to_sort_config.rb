class AddGroupSizeToSortConfig < ActiveRecord::Migration
  def change
    add_column :sort_configs, :group_size, :integer
  end
end
