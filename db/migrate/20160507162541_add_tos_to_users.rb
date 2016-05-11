class AddTosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tos, :boolean, null: false, default: false
  end
end
