class VoiceBank < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true
	validates :name, presence: true
	validates :download_link, presence: true
end
