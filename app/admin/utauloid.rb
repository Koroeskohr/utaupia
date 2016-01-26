ActiveAdmin.register Utauloid do
  menu priority: 3

	permit_params :name, :japanese_name, :description, 
		:gender, :category_id, :wiki_url, :vocadb_url, 
		voice_characteristic_ids: [],
		voice_language_ids: [],
		voicebank_type_ids: []

	scope :all, :default => true

	filter :name
	filter :japanese_name
	filter :gender
	filter :category_id

	index do
		selectable_column
		id_column
		column :name
		column :japanese_name
		column :gender do |utauloid| 
			utauloid.gender.titleize 
		end
		column :category do |utauloid|
			utauloid.category.name
		end

		column :creator do |utauloid|
			if utauloid.creator.is_a? User
				link_to utauloid.creator.nickname, admin_user_path(utauloid.creator)
			else
				utauloid.creator
			end
		end
		column :wiki_url
		column :vocadb_url
		column :created_at
		column :updated_at
		actions
	end

	show :title => :name do
		render 'info_full', utauloid: utauloid
		render 'voice_banks', utauloid: utauloid
	end

	form partial: 'form'

	controller do
		def find_resource
			scoped_collection.friendly.find(params[:id])
		end
	end

end
