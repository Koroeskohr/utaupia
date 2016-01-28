class CreateUtauloidComments < ActiveRecord::Migration
  def change
    create_table :utauloid_comments do |t|
    	t.integer :user_id, null: false
    	t.integer :utauloid_id, null: false
    	t.text :message, null: false
      t.timestamps null: false
    end
  end
end
