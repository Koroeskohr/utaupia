class CreateUtauloids < ActiveRecord::Migration
  def change
    create_table :utauloids do |t|
      t.string :name, null: false
      t.integer :gender, null: false # Integer is for enumeration in Utauloid model
      t.integer :age

      t.timestamps null: false
    end
  end
end
