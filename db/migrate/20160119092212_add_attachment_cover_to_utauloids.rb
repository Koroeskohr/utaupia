class AddAttachmentCoverToUtauloids < ActiveRecord::Migration
  def self.up
    change_table :utauloids do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :utauloids, :cover
  end
end
