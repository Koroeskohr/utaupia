class AddFriendlySlugs < ActiveRecord::Migration
  def change
    add_column :utauloids, :slug, :string, unique: true
    add_index :utauloids, :slug

    add_column :users, :slug, :string, unique: true
    add_index :users, :slug

    add_column :categories, :slug, :string, unique: true
    add_index :categories, :slug

    add_column :voicebank_types, :slug, :string, unique: true
    add_index :voicebank_types, :slug

    add_column :voice_languages, :slug, :string, unique: true
    add_index :voice_languages, :slug

    add_column :voice_characteristics, :slug, :string, unique: true
    add_index :voice_characteristics, :slug
  end
end
