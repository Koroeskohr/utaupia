module MessagesHelper
	def get_content_message(str, author_id, utauloid_id)
		utauloid = Utauloid.find(utauloid_id)
		author = User.find(author_id)

		str.gsub!('[:utauloid_name:]', utauloid.name)
		str.gsub!('[:utauloid_link:]', link_to(utauloid.name, utauloid_path(utauloid)))
		str.gsub!('[:author_name:]', author.nickname)
		str.gsub!('[:author_link:]', link_to(author.nickname, user_path(author)))
		str
	end
end
