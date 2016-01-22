class Message < ActiveRecord::Base
	belongs_to :user

	enum message_type: [:notif_new_comment, :notif_new_favorite, :notif_new_update, :personnal_message]

	validates :user_id, presence: true
	validates :message_type, presence: true,
														inclusion: { in: message_types.keys }
	validates :message, presence: true,
											length: { maximum: 1000 }
	validates :deleted, inclusion: { in: [true, false] }
	validates :seen, inclusion: { in: [true, false] }
end
