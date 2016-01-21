class VoiceBank < ActiveRecord::Base
  include UrlHelper

  after_save :add_protocol_to_url

	validates :utauloid_id, presence: true
	validates :name, presence: true, length: { maximum: 255 }
	validates :download_link, presence: true, :url => { :allow_blank => true, :no_local => true }

  belongs_to :utauloid

  private
  def add_protocol_to_url
    self.download_link = url_with_protocol(self.download_link)
  end
end
