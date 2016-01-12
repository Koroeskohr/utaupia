class CreateUserLinks < ActiveRecord::Migration
  def change
    create_table :user_links do |t|
    
      t.text :link
      t.integer :user_info_id 

      t.timestamps null: false
    end
  end
end
