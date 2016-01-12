class AddIsAppendToVoiceBank < ActiveRecord::Migration
  def change
    add_column :voice_banks, :is_append, :bool, null: false, default: true
  end
end
