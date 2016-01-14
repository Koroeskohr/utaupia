class UserInfo < ActiveRecord::Base
	validates :user_id, presence: true
	validates :description, length: { maximum: 3000 }
	validates :favorites_are_showable, :inclusion => {:in => [true, false]}
	validates :utauloids_are_showable, :inclusion => {:in => [true, false]}
	validates :notif_when_vb_updated, :inclusion => {:in => [true, false]}
	validates :notif_when_utauloid_faved, :inclusion => {:in => [true, false]}
	validates :notif_when_utauloid_commented, :inclusion => {:in => [true, false]}

	belongs_to :user
  has_many :user_links
  accepts_nested_attributes_for :user_links, reject_if: lambda {|attributes| attributes['link'].blank?}, allow_destroy: true
end
