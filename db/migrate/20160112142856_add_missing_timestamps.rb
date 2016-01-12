class AddMissingTimestamps < ActiveRecord::Migration
  def change
		add_column(:utauloid_types, :created_at, :datetime)
		add_column(:utauloid_types, :updated_at, :datetime)

		add_column(:utaloid_characteristics, :created_at, :datetime)
		add_column(:utaloid_characteristics, :updated_at, :datetime)
  end
end
