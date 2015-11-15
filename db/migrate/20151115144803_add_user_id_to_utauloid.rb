class AddUserIdToUtauloid < ActiveRecord::Migration
  def change
  	add_column :utauloids, :user_id, :integer
  end
end
