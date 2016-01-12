class CreateUtauloids < ActiveRecord::Migration
  def change
    create_table :utauloids do |t|
      t.string :name, null: false
      t.string :japanese_name
      t.integer :gender, null: false # Integer is for enumeration in Utauloid model
      t.timestamp :vb_release_date
      t.timestamp :vb_last_update
      t.boolean :show_appends, null: false
      t.integer :category_id
      t.string :creator
      t.boolean :creator_is_user
      t.integer :creator_id
      t.integer :difficulty
      t.text :wiki_url
      t.text :vocadb_url

      t.timestamps null: false
    end
  end
end
