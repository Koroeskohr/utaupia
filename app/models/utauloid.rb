class Utauloid < ActiveRecord::Base
	enum gender: [:male, :female, :undefined, :other]
  
  validates :name, presence: true, 
                   length: { maximum: 60 } 
  validates :japanese_name, length: { maximum: 60 }, 
                            allow_blank: true
  validates :gender, presence: true, 
                     inclusion: { in: genders.keys }
  validates_datetime :vb_release_date, allow_blank: true
  validates_datetime :vb_last_update, allow_blank: true
  validates :creator, length: { maximum: 60 } 
  validates :creator_id, presence: true 
  validates :difficulty, inclusion: { in: 1..5 }, allow_blank: true
  validates :wiki_url, format: { with: /\A(http(s)?:\/\/)?utau.wikia.com\/wiki\/.*\z/i},
                       length: { maximum: 300 },
                       allow_blank: true
  validates :vocadb_url, format: { with: /\A(http(s)?:\/\/)?(www.)?vocadb.net\/.*\z/i},
                         length: { maximum: 300 },
                         allow_blank: true
  
  has_many :voice_banks
  
  has_many :voice_characteristics, through: :utauloid_characteristics
  has_many :voice_languages, through: :utauloid_languages
  has_many :voicebank_types, through: :utauloid_types

  has_many :favorite_utauloids
  has_many :favorited_by, through: :favorite_utauloids, source: :user
	
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :category
end
