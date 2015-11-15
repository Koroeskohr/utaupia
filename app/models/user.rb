class User < ActiveRecord::Base
	validates :nickname, presence: true, uniqueness: true, length: { maximum: 25 }
	validates :email, 	presence: true, 
						uniqueness: true, 
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	

end
