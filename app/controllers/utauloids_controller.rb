class UtauloidsController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]


	def show
		@utauloid = Utauloid.friendly.find(params[:id])
	end

	def index
		@utauloids = Utauloid.all
	end

	def new
		@utauloid = Utauloid.new
		@categories = Category.all

	end

	def create
		@utauloid = Utauloid.new(utauloid_params)
		@utauloid.creator = current_user

		@voice_languages = VoiceLanguage.where(id: utauloid_params[:voice_language_ids])
		@utauloid.voice_languages << @voice_languages

		@voicebank_types = VoicebankType.where(id: utauloid_params[:voicebank_type_ids])
		@utauloid.voicebank_types << @voicebank_types

		@voice_characteristics = VoiceCharacteristic.where(id: utauloid_params[:voice_characteristic_ids])
		@utauloid.voice_characteristics << @voice_characteristics

		if @utauloid.creator_name.nil? 
			@utauloid.creator_is_user = true
		end

		if @utauloid.save
			redirect_to @utauloid
		else
			render 'new'
		end
			
	end

	def edit
		@utauloid = Utauloid.friendly.find(params[:id])
	end

	def update
		@utauloid = Utauloid.friendly.find(params[:id])

		@voice_languages = VoiceLanguage.where(id: utauloid_params[:voice_language_ids])
		@utauloid.voice_languages.each do |vl|
			if !@voice_languages.include?(vl)
				@utauloid.voice_languages.delete(vl)
			end
		end
		@utauloid.voice_languages << @voice_languages unless @utauloid.voice_languages.include?(@voice_languages)

		@voicebank_types = VoicebankType.where(id: utauloid_params[:voicebank_type_ids])
		@utauloid.voicebank_types.each do |vt|
			if !@voicebank_types.include?(vt)
				@utauloid.voicebank_types.delete(vt)
			end
		end
		@utauloid.voicebank_types << @voicebank_types unless @utauloid.voicebank_types.include?(@voicebank_types)

		@voice_characteristics = VoiceCharacteristic.where(id: utauloid_params[:voice_characteristic_ids])
		@utauloid.voice_characteristics.each do |vt|
			if !@voice_characteristics.include?(vt)
				@utauloid.voice_characteristics.delete(vt)
			end
		end
		@utauloid.voice_characteristics << @voice_characteristics unless @utauloid.voice_characteristics.include?(@voice_characteristics)

		if(@utauloid.update_attributes(utauloid_params))
			redirect_to @utauloid
		end
	end

	private
		def utauloid_params
			params.require(:utauloid).permit(:name,
																			:japanese_name,
																			:gender,
																			:category_id,
																			{ :voice_language_ids => [] },
																			{ :voicebank_type_ids => [] },
																			{ :voice_characteristic_ids => [] },
																			:vb_release_date,
																			:vb_last_update,
																			:creator_name,
																			:wiki_url,
																			:vocadb_url)
		end
end
