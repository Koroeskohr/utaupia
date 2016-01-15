class UtauloidComment < ActiveRecord::Base
	validates :user_id, presence: true
	validates :utauloid_id, presence: true, uniqueness: { scope: :user_id }
	validates :message, presence: true

	belongs_to :user
  belongs_to :utauloid
end
