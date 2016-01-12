class VoicebankType < ActiveRecord::Base
	has_many :utauloids, through: :utauloids_types

	validates :name, presence: true, length: {in: 1..255}
end
