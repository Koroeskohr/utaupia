class CreateDifficultyVotes < ActiveRecord::Migration
  def change
    create_table :difficulty_votes do |t|
    	t.integer :user_id, null: false
    	t.integer :utauloid_id, null: false
    	t.integer :note, null: false
    end
  end
end
