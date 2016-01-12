class CreateVoiceLanguages < ActiveRecord::Migration
  def change
    create_table :voice_languages do |t|
    	t.string :name, null: false
      t.timestamps null: false
    end
  end
end
