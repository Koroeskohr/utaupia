class FavoriteUtauloid < ActiveRecord::Base
  validates :user_id, presence: true
  validates :utauloid_id, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :utauloid
end