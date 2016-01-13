class UserInfo < ActiveRecord::Base
	validates :user_id, presence: true
	validates :description, length: { maximum: 3000 }
	validates :favorites_are_showable, presence: true
	validates :utauloids_are_showable, presence: true
	validates :notif_when_vb_updated, presence: true
	validates :notif_when_utauloid_faved, presence: true
	validates :notif_when_utauloid_commented, presence: true

	belongs_to :user
  has_many :user_links
end
