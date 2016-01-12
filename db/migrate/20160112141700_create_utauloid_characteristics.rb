class CreateUtaloidCharacteristics < ActiveRecord::Migration
  def change
    create_table :utaloid_characteristics do |t|
    	t.integer :utauloid_id, null: false
    	t.integer :voice_characteristic_id, null: false
    end
  end
end
