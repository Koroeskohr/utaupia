class Image < ActiveRecord::Base
	has_attached_file :img,
		:path => ":rails_root/public/assets/:attachment/:id/:basename_:style.:extension",
		:url => "/assets/:attachment/:id/:basename_:style.:extension",
		styles: { medium: "300x300>", thumb: "100x100>" },
		default_url: ":rails_root/public/assets/images/:style/missing.png"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\Z/
end
