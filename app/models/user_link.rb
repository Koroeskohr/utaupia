class UserLink < ActiveRecord::Base
	validates :user_info_id, presence: true
	validates :link, presence: true

	belongs_to :user_info
end
