class Category < ActiveRecord::Base
	validates :name, presence: true, length: { in: 1..100 }

  has_many :utauloids
end
