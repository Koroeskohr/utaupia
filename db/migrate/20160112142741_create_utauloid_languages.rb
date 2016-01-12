class CreateUtaloidLanguages < ActiveRecord::Migration
  def change
    create_table :utaloid_languages do |t|
    	t.string :name, null: false
    	t.timestamps null: false
    end
  end
end
