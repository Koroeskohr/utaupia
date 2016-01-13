class VoiceBank < ActiveRecord::Base
	validates :utauloid_id, presence: true
	validates :name, presence: true, length:{ maximum: 255 }
	validates :download_link, presence: true

  belongs_to :utauloid
end
