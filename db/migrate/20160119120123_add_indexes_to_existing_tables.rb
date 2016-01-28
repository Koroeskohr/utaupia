class AddIndexesToExistingTables < ActiveRecord::Migration
  def change
    add_index :difficulty_votes, [:user_id, :utauloid_id]
    add_index :favorite_utauloids, [:user_id, :utauloid_id]
    add_index :utauloid_comments, [:user_id, :utauloid_id]
    
    add_index :utauloid_characteristics, [:utauloid_id, :voice_characteristic_id], name: 'ul_charac_index'
    add_index :utauloid_languages, [:utauloid_id, :voice_language_id], name: 'ul_language_index'
    add_index :utauloid_types, [:utauloid_id, :voicebank_type_id]
    
    add_index :user_infos, :user_id
    add_index :user_links, :user_info_id

    add_index :utauloids, :category_id
    add_index :utauloids, :creator_id

  end
end
