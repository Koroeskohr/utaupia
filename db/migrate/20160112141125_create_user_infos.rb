class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :user_id, null: false
      t.text :description
      t.boolean :favorites_are_showable, null: false, default: true
      t.boolean :utauloids_are_showable, null: false, default: true
      t.boolean :notif_when_vb_updated, null: false, default: true
      t.boolean :notif_when_utauloid_faved, null: false, default: true
      t.boolean :notif_when_utauloid_commented, null: false, default: true
      t.timestamps null: false
    end
  end
end
