class AddUtauloidToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :utauloid_id, :int
  end
end
