class VoiceCharacteristic < ActiveRecord::Base
	has_many :utauloids, through: :utauloids_characteristics

	validates :name, presence: true, length: {in: 1..255}
end
