class CreateUtauloidLanguages < ActiveRecord::Migration
  def change
    create_table :utauloid_languages do |t|
      t.integer :utauloid_id
    	t.integer :voice_language_id
    	t.timestamps null: false
    end
  end
end
