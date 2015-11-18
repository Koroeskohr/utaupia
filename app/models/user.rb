class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
	validates :nickname, presence: true, uniqueness: true, length: { maximum: 25 }
	validates :email, 	presence: true, 
						uniqueness: true, 
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	has_many :utauloids

end
