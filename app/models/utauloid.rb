class Utauloid < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

	enum gender: [:male, :female, :undefined, :other]

  validates :name, presence: true, 
                   length: { maximum: 60 },
                   uniqueness: true
  validates :japanese_name, length: { maximum: 60 }, 
                            allow_blank: true
  validates :description, length: { maximum: 5000 }, allow_blank: true
  validates :gender, presence: true, 
                     inclusion: { in: genders.keys }
  validates_datetime :vb_release_date, allow_blank: true
  validates_datetime :vb_last_update, allow_blank: true
  validates :creator_name, length: { maximum: 60 } 
  validates :creator_is_user, inclusion: { in: [true, false] }
  validates :creator_id, presence: true 
  validates :difficulty, inclusion: { in: 1..5 }, allow_blank: true
  validates :wiki_url, format: { with: /\A(http(s)?:\/\/)?utau.wikia.com\/wiki\/.*\z/i },
                       length: { maximum: 300 },
                       allow_blank: true
  validates :vocadb_url, format: { with: /\A(http(s)?:\/\/)?(www.)?vocadb.net\/.*\z/i },
                         length: { maximum: 300 },
                         allow_blank: true

  has_many :voice_banks
  accepts_nested_attributes_for :voice_banks, :allow_destroy => true

  has_and_belongs_to_many :voice_characteristics, join_table: :utauloid_characteristics
  has_and_belongs_to_many :voice_languages, join_table: :utauloid_languages
  has_and_belongs_to_many :voicebank_types, join_table: :utauloid_types

  accepts_nested_attributes_for :voice_characteristics, :allow_destroy => true
  accepts_nested_attributes_for :voice_languages, :allow_destroy => true
  accepts_nested_attributes_for :voicebank_types, :allow_destroy => true

  validates :voice_languages, presence: true
  validates :voicebank_types, presence: true

  has_many :favorite_utauloids
  has_many :favorited_by, through: :favorite_utauloids, source: :user

  has_many :utauloid_comments
  has_many :difficulty_votes

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :category

  has_many :reports, as: :reportable

  has_attached_file :avatar,
    :path => ":rails_root/public/utauloids/:attachment/:hash_:style.:extension",
    :url => "/utauloids/:attachment/:hash_:style.:extension",
    :hash_secret => RANDOM_SECRET,
    styles: {
      medium: "210x210#",
      thumb: "100x100#" },
    :convert_options => {
      :medium => "-quality 80",
      :thumb => "-quality 80"
    },
    default_url: "/utauloids/:attachment/utauloid_default_avatar.jpg"

  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_size :avatar, { in: 0..500.kilobytes }

  has_attached_file :cover,
    :path => ":rails_root/public/utauloids/:attachment/:hash_:style.:extension",
    :url => "/utauloids/:attachment/:hash_:style.:extension",
    :hash_secret => RANDOM_SECRET,
    styles: {
      medium: "280x280#",
      thumb: "100x100#" },
    :convert_options => {
      :medium => "-quality 80",
      :thumb => "-quality 80"
    },
    default_url: "/utauloids/:attachment/utauloid_default_cover.jpg"

  validates_attachment_content_type :cover, content_type: /\Aimage/
  validates_attachment_size :cover, { in: 0..1000.kilobytes }

  has_attached_file :audio_preview,
    :path => ":rails_root/public/utauloids/:attachment/:hash.:extension",
    :url => "/utauloids/:attachment/:hash.:extension",
    :hash_secret => RANDOM_SECRET

  validates_attachment_content_type :audio_preview, :content_type => /\Aaudio/ #[ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
  validates_attachment_size :audio_preview, { in: 0..1000.kilobytes }

  scope :with_name, -> name { where("utauloids.name LIKE ?", "%#{name}%") unless name.blank? }
  scope :with_gender, -> gender { where(gender: self.genders.values_at(*gender)) unless gender.blank? }
  scope :with_category, -> category { where(category: category) unless category.blank? }
  scope :with_creator_name, -> creator_name {
    if !creator_name.blank?
      joins(:creator)
        .joins("INNER JOIN user_infos ON (user_infos.user_id = users.id)")
        .where("(utauloids.creator_is_user = ? AND users.nickname LIKE ? AND user_infos.utauloids_are_showable = ?) OR (utauloids.creator_is_user = ? AND utauloids.creator_name LIKE ?)", true, "%#{creator_name}%", true, false, "%#{creator_name}%")
    end
  }
  scope :with_voice_language, -> language { joins(:voice_languages).where(voice_languages: { id: language }) unless language.blank? }
  scope :with_voicebank_type, -> voicebank_type { joins(:voicebank_types).where(voicebank_types: { id: voicebank_type }) unless voicebank_type.blank? }
  scope :with_voice_characteristic, -> voice_characteristic { joins(:voice_characteristics).where(voice_characteristics: { id: voice_characteristic }) unless voice_characteristic.blank? }
  scope :with_release_date, -> release_date {
    if !release_date.blank?
      if release_date.include?("sup_")
        return where("utauloids.vb_release_date <= ?", UtauloidsController.helpers.get_query_date(release_date))
      else
        return where("utauloids.vb_release_date >= ?", UtauloidsController.helpers.get_query_date(release_date))
      end
    end
  }
  scope :with_update_date, -> update_date { where("utauloids.vb_last_update >= ?", UtauloidsController.helpers.get_query_date(update_date)) unless update_date.blank? }

  def self.search(s = {})
    self
      .with_name(s[:name])
      .with_gender(s[:gender])
      .with_category(s[:group])
      .with_creator_name(s[:creator_name])
      .with_voice_language(s[:language])
      .with_voicebank_type(s[:voicebank_type])
      .with_voice_characteristic(s[:voice_characteristic])
      .with_release_date(s[:release_date])
      .with_update_date(s[:update_date])
      .order("id DESC")
      .uniq
  end

  def creator
    creator_is_user ? User.find_by_id(creator_id) : creator_name
  end

  def uploader
    User.find_by_id(creator_id)
  end
end
