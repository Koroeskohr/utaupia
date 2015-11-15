class Utauloid < ActiveRecord::Base
	validates :name, presence: true
	validates :gender, presence: true
	validates :age, numericality: { only_integer: true, greater_than: 1 }

	
	enum gender: [:male, :female]

	belongs_to :user
end
