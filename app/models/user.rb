class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nickname, use: :slugged

  self.per_page = 25

  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :email, presence: true, 
            uniqueness: true, 
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  enum role: [:user, :moderator, :administrator]

  has_many :utauloids, foreign_key: "creator_id"
  has_many :favorite_utauloids
  has_many :favorites, through: :favorite_utauloids, source: :utauloid
  has_many :utauloid_comments
  has_many :difficulty_votes
  has_one :user_info
  has_many :messages
  accepts_nested_attributes_for :user_info


  private
  def set_default_role
    self.role ||= :user
  end

end
