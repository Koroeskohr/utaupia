class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname, unique: true, null: false
      t.string :email, unique: true, null: false

      t.timestamps null: false
    end
  end
end
