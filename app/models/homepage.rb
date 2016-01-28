class Homepage < ActiveRecord::Base
  belongs_to :utauloid_showcase, foreign_key: "utauloid_showcase", class_name: 'Utauloid'

  def self.instance
    first
  end
end
