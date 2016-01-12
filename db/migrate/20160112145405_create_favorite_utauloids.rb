class CreateFavoriteUtauloids < ActiveRecord::Migration
  def change
    create_table :favorite_utauloids do |t|
    	t.integer :user_id, null: false
    	t.integer :utauloid_id, null: false
    end
  end
end
