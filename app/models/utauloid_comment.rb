class UtauloidComment < ActiveRecord::Base
	validates :user_id, presence: true
	validates :utauloid_id, presence: true
	validates :message, presence: true

	belongs_to :user
  belongs_to :utauloid
end
