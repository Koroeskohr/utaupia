class DifficultyVote < ActiveRecord::Base
	validates :user_id, presence: true
	validates :utauloid_id, presence: true
	validates :note, presence: true, inclusion: { in: 1..5 }

	belongs_to :user
  belongs_to :utauloid
end
