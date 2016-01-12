class Utauloid < ActiveRecord::Base
	enum gender: [:male, :female, :undefined, :other]
  
  validates :name, presence: true, length: { in: 1..60 } 
  validates :japanese_name, length: { in: 1..60 } 
  validates :gender, presence: true, inclusion: { in: genders.keys }
  validates_datetime :vb_release_date
  validates_datetime :vb_last_update
  validates :category_id, presence: true
  validates :creator, length: { in: 1..60 } 
  validates :creator_id, presence: true 
  validates :difficulty, inclusion: { in: 1..5 }
  validates :wiki_url, format: { with: /\A(http(s)?:\/\/)?utau.wikia.com\/wiki\/.*\z/i},
                       length: { in: 1..300 }
  validates :vocadb_url, format: { with: /\A(http(s)?:\/\/)?(www.)?vocadb.net\/.*\z/i},
                         length: { in: 1..300 }
  

	belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
end
