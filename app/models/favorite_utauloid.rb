class FavoriteUtauloid < ActiveRecord::Base
  belongs_to :user
  belongs_to :utauloid
end