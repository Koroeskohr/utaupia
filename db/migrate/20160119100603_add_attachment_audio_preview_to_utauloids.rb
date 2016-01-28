class AddAttachmentAudioPreviewToUtauloids < ActiveRecord::Migration
  def self.up
    change_table :utauloids do |t|
      t.attachment :audio_preview
    end
  end

  def self.down
    remove_attachment :utauloids, :audio_preview
  end
end
