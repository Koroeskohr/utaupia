class CreateUtauloidTypes < ActiveRecord::Migration
  def change
    create_table :utauloid_types do |t|
    	t.integer :utauloid_id, null: false
    	t.integer :voicebank_type_id, null: false
    end
  end
end
