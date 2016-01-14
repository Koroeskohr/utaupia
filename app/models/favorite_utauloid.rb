class FavoriteUtauloid < ActiveRecord::Base
  validates :user_id, presence: true
  validates :utauloid_id, presence: true

  belongs_to :user
  belongs_to :utauloid
end