class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, null: false, default: User.roles[:user]
  end
end
