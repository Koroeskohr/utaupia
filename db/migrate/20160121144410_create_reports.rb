class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id, null: false
      t.integer :reportable_id, null: false
      t.string :reportable_type, null: false

      t.timestamps null: false
    end

    add_index :reports, [:user_id, :reportable_id, :reportable_type]
  end
end
