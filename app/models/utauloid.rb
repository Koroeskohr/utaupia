class Utauloid < ActiveRecord::Base
	validates :name, presence: true, length: { in: 1..255 } 
  validates :japanese_name, length: { in: 1..255 } 
	validates :gender, presence: true, inclusion: { in: Utauloid.genders.keys }
  validates_datetime :vb_release_date
  validates_datetime :vb_last_update
  validates :creator, length: { in: 1..60 } 
  validates :difficulty, inclusion: { in: 1..5 }
  validates :wiki_url, format: { in: /\A(http(s)?:\/\/)?utau.wikia.com\/wiki\/.*\z/i}
  validates :vocadb_url, format: { in: /\A(http(s)?:\/\/)?(www.)?vocadb.net\/.*\z/i}


	
	enum gender: [:male, :female, :undefined, :other]

	belongs_to :user
end
