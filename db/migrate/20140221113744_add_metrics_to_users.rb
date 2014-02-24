class AddMetricsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_use, :date
    add_column :users, :last_login, :date
  end
end
