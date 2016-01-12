class VoiceLanguage < ActiveRecord::Base
	has_many :utauloids, through: :utauloids_languages

	validates :name, presence: true, length: {in: 1..255}
end
