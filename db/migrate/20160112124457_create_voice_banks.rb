class CreateVoiceBanks < ActiveRecord::Migration
  def change
    create_table :voice_banks do |t|
    	t.integer :user_id, index: true
    	t.string :name, null: false
    	t.text :download_link, null: false
      t.timestamps null: false
    end
  end
end
