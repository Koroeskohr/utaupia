ActiveAdmin.register Utauloid do
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
		panel "Utauloid info" do
			attributes_table_for utauloid do
				row :id
				row :name
				row :japanese_name
				row :description
				row :gender do
					utauloid.gender.titleize
				end
				row "Release date", :vb_release_date do
					pretty_format utauloid.vb_release_date
				end
				row "Last update", :vb_last_update do
					pretty_format utauloid.vb_last_update
				end
				row :category do 
					utauloid.category.name
				end
				row :creator do |utauloid|
					if utauloid.creator.is_a? User
						link_to utauloid.creator.nickname, admin_user_path(utauloid.creator)
					else
						utauloid.creator
					end
				end
				row :voice_characteristics do |utauloid|
					utauloid.voice_characteristics.pluck(:name).join ', '
				end
				row :voice_languages do |utauloid|
					utauloid.voice_languages.pluck(:name).join ', '
				end
				row :voicebank_types do |utauloid|
					utauloid.voicebank_types.pluck(:name).join ', '
				end
				row :difficulty
				row :wiki_url
				row :vocadb_url
			end
		end

		panel "Voice banks" do
			table_for utauloid.voice_banks do
				column :name
				column :download_link
				column :created_at
			end
		end

	end

	form do |f|
		f.semantic_errors # shows errors on :base
		f.inputs 'Details' do
			f.input :name
			f.input :japanese_name
			f.input :description
			f.input :gender, :as => :select, :collection => Utauloid.genders.keys.to_a.map { |g| [g.humanize, g] }
			f.input :category_id, :as => :select, :collection => Category.all
			f.input :voice_characteristics, :as => :check_boxes, :collection => VoiceCharacteristic.all
			f.input :voice_languages, :as => :check_boxes, :collection => VoiceLanguage.all
			f.input :voicebank_types, :as => :check_boxes, :collection => VoicebankType.all
			f.input :wiki_url
			f.input :vocadb_url

			f.has_many :voice_banks, heading: "Voice banks", allow_destroy: true do |vb|
				vb.input :name
				vb.input :download_link
			end

			li "Created at #{f.object.created_at}" unless f.object.new_record?
		end

		f.actions
	end

	controller do
		def find_resource
			scoped_collection.friendly.find(params[:id])
		end
	end

end
