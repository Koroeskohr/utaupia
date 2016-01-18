class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nickname, use: :slugged

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
  has_many :favorite_utauloids
  has_many :favorites, through: :favorite_utauloids, source: :utauloid
  has_many :utauloid_comments
  has_many :difficulty_votes
  has_one :user_info
  accepts_nested_attributes_for :user_info

  def set_default_role
    self.role ||= :user
  end
end
