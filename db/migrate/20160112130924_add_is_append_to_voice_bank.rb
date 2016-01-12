class AddIsAppendToVoiceBank < ActiveRecord::Migration
  def change
    add_column :voicebank_types, :is_append, :bool, null: false, default: true
  end
end
