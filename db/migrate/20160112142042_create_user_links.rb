class CreateUserLinks < ActiveRecord::Migration
  def change
    create_table :user_links do |t|
      t.integer :user_info_id , null: false
      t.text :link, null: false
      t.timestamps null: false
    end
  end
end
