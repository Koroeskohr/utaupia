class UtauloidsController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]


	def show
		@utauloid = Utauloid.friendly.find(params[:id])
		@comments = @utauloid.utauloid_comments
		@comment  = @utauloid.utauloid_comments.build
		if current_user
			get_difficulty_vote
		end
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
		@utauloid.creator_is_user = @utauloid.creator_name.nil? 

		@utauloid.voice_languages << VoiceLanguage.where(id: params[:voice_language_ids])
		@utauloid.voicebank_types << VoicebankType.where(id: params[:voicebank_type_ids])
		@utauloid.voice_characteristics << VoiceCharacteristic.where(id: params[:voice_characteristic_ids])

		if @utauloid.save!
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

		params[:voice_language_ids] ||= []
		params[:voicebank_type_ids] ||= []
		params[:voice_characteristic_ids] ||= []

		languages = VoiceLanguage.where(params[:voice_language_ids])
		@utauloid.voice_languages = languages
		types = VoicebankType.where(params[:voicebank_type_ids])
		@utauloid.voicebank_types = types
		characteristics = VoiceCharacteristic.where(params[:voice_characteristic_ids])
		@utauloid.voice_characteristics = characteristics

		if @utauloid.update_attributes!(utauloid_params)
			redirect_to @utauloid
		end
	end

private
	def utauloid_params
		params.require(:utauloid).permit(:name,
																		:japanese_name,
																		:avatar,
																		:cover,
																		:audio_preview,
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

	def get_difficulty_vote
		@difficulty_vote = DifficultyVote.where(user_id: current_user.id, utauloid_id: @utauloid.id).first
		if @difficulty_vote.nil?
			@difficulty_vote = @utauloid.difficulty_votes.build
		end
	end
end	
