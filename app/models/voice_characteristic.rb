class VoiceCharacteristic < ActiveRecord::Base
  validates :name, presence: true, length: { in: 1..255 }
  
	has_and_belongs_to_many :utauloids, join_table: :utauloid_characteristics
end
