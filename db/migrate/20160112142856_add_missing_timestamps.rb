class AddMissingTimestamps < ActiveRecord::Migration
  def change
		add_column(:utauloid_types, :created_at, :datetime)
		add_column(:utauloid_types, :updated_at, :datetime)

		add_column(:utauloid_characteristics, :created_at, :datetime)
		add_column(:utauloid_characteristics, :updated_at, :datetime)
  end
end
