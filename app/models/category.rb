class Category < ActiveRecord::Base
	has_many :utauloids

	validates :name, presence: true, length: { in: 1..100}
end
