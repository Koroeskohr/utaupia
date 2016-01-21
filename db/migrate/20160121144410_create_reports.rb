class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id, null: false
      t.integer :reportable_id, null: false
      t.string :reportable_type, null: false

      t.timestamps null: false
    end
  end
end
