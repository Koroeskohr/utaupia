class VoicebankType < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
	
  has_and_belongs_to_many :utauloids, join_table: :utauloid_types
end
