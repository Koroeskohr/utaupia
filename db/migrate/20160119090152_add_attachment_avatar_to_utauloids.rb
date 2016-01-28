class AddAttachmentAvatarToUtauloids < ActiveRecord::Migration
  def self.up
    change_table :utauloids do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :utauloids, :avatar
  end
end
