class User < ActiveRecord::Base
  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	validates :nickname, presence: true, uniqueness: true, length: { maximum: 25 }
	validates :email, 	presence: true, 
						uniqueness: true, 
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  enum role: [:user, :moderator, :administrator]

	has_many :utauloids

  def set_default_role
    self.role ||= :user
  end
end
