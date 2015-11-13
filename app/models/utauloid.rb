class Utauloid < ActiveRecord::Base
	validates :name, presence: true
	validates :gender, presence: true
	
	enum gender: [:male, :female]

end
