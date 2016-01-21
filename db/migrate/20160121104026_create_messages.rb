class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :user_id, null: false
    	t.integer :message_type, null: false
    	t.text :message, null: false
    	t.integer :author_id
    	t.boolean :deleted, default: false
    	t.boolean :seen, default: false
      t.timestamps null: false
    end
  end
end
