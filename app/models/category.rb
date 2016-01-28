class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
	validates :name, presence: true, length: { maximum: 100 }, uniqueness: true

  has_many :utauloids
end
