class VoiceCharacteristic < ActiveRecord::Base
  validates :name, presence: true, length: { in: 1..255 }
  
	has_many :utauloids, through: :utauloid_characteristics
end
