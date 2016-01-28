class AddIsAppendToVoiceBank < ActiveRecord::Migration
  def change
    add_column :voice_banks, :is_append, :boolean, null: false, default: false
  end
end
