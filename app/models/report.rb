class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :user_id, presence: true, uniqueness: { scope: [:reportable_id, :reportable_type] }
end
