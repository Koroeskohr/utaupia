class UserInfo < ActiveRecord::Base
	validates :user_id, presence: true
	validates :description, length: { maximum: 3000 }
	validates :favorites_are_showable, inclusion: { in: [true, false] }
	validates :utauloids_are_showable, inclusion: { in: [true, false] }
	validates :notif_when_vb_updated, inclusion: { in: [true, false] }
	validates :notif_when_utauloid_faved, inclusion: { in: [true, false] }
	validates :notif_when_utauloid_commented, inclusion: { in: [true, false] }

	belongs_to :user
  has_many :user_links

	has_attached_file :avatar,
		:path => ":rails_root/public/users/:attachment/:hash_:style.:extension",
		:url => "/users/:attachment/:hash_:style.:extension",
		:hash_secret => RANDOM_SECRET,
		styles: {
			medium: "100x",
			thumb: "100x100#" },
		:convert_options => {
			:medium => "-quality 80",
			:thumb => "-quality 80"
		},
		default_url: ":rails_root/public/assets/:attachment/:style/missing.png"

	validates_attachment_content_type :avatar, content_type: /\Aimage/
	validates_attachment_size :avatar, { in: 0..500.kilobytes }

  accepts_nested_attributes_for :user_links, reject_if: lambda {|attributes| attributes['link'].blank?}, allow_destroy: true
end
