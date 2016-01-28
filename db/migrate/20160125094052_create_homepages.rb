class CreateHomepages < ActiveRecord::Migration
  def change
    create_table :homepages do |t|
    	t.integer :utauloid_showcase
      t.timestamps null: false
    end
  end
end
