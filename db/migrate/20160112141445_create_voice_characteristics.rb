class CreateVoiceCharacteristics < ActiveRecord::Migration
  def change
    create_table :voice_characteristics do |t|
			t.string :name, null: false
			t.timestamps null: false
    end
  end
end
