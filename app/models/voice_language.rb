class VoiceLanguage < ActiveRecord::Base
  validates :name, presence: true, length: {in: 1..255}
	
  has_many :utauloids, through: :utauloids_languages
end
