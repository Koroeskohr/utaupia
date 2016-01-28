class MessagesService
	def self.create_messages(params)
		message_type = params[:message_type]
		utauloid_id = params[:utauloid_id]

		if message_type != false
			case message_type
			when "notif_new_comment"
				create_messages_new_comment(message_type, utauloid_id, params[:user_id])
			when "notif_new_favorite"
				create_message_new_favorite(message_type, utauloid_id, params[:user_id])
			when "notif_new_update"
				create_messages_update(message_type, utauloid_id)
			end
		end
	end

	def self.create_messages_new_comment(message_type, utauloid_id, user_id)
		user = User.joins(:user_info)
								.where("user_infos.notif_when_utauloid_commented = ?", true)
								.joins(:utauloids)
								.where("utauloids.id = ? AND utauloids.creator_is_user = ? AND users.id = utauloids.creator_id", utauloid_id, true)
								.limit(1)
								.first

		if !user.blank?
			utauloid = Utauloid.find(utauloid_id)
			commenter = User.find(user_id)

			user.messages.create(message_type: message_type,
													title: "New comment on your Utauloid #{utauloid.name}:",
													message: "#{commenter.nickname} posted a message on your Utauloid #{utauloid.name}. Check it!")
		end
	end

	def self.create_message_new_favorite(message_type, utauloid_id, user_id)
		user = User.joins(:user_info)
								.where("user_infos.notif_when_utauloid_faved = ?", true)
								.joins(:utauloids)
								.where("utauloids.id = ? AND utauloids.creator_is_user = ? AND users.id = utauloids.creator_id", utauloid_id, true)
								.limit(1)
								.first

		if !user.blank?
			utauloid = Utauloid.find(utauloid_id)
			commenter = User.find(user_id)

			user.messages.create(message_type: message_type,
													title: "New favorite on your Utauloid #{utauloid.name}:",
													message: "#{commenter.nickname} fav your Utauloid #{utauloid.name}. Check it!")
		end
	end

	def self.create_messages_update(message_type, utauloid_id)
		users = User.joins(:user_info)
									.where("user_infos.notif_when_vb_updated = ?", true)
									.joins(:favorite_utauloids)
									.where("favorite_utauloids.user_id = users.id AND favorite_utauloids.utauloid_id = ?", utauloid_id)

		if !users.blank?
			utauloid = Utauloid.find(utauloid_id)

			users.each do |user|
				user.messages.create(message_type: message_type,
														title: "New update on Utauloid #{utauloid.name}!",
														message: "The Utauloid #{utauloid.name} have been updated! Check what's new")
			end
		end
	end
end