class UtauloidsController < ApplicationController
	before_action :ensure_xhr, only: [:report]
	before_action :authenticate_user!, except: [:show, :index]
	before_action :ensure_belonging, only: [:edit]

	def show
		@utauloid = Utauloid.friendly.find(params[:id])
		@comments = @utauloid.utauloid_comments
		@comment  = @utauloid.utauloid_comments.build unless !current_user
		@voice_banks = @utauloid.voice_banks.order(is_append: :asc)
		notes = @utauloid.difficulty_votes.all
		if !notes.blank?
			@note = 0
			notes.each do |n|
				@note += n.note
			end
			@note = (@note.to_f/notes.count.to_f).round
		end
		if current_user
			get_difficulty_vote
		end

		@page_title = @utauloid.name
	end

	def index
		if params[:commit] && params[:commit].downcase == "search"
			@utauloids = Utauloid.search(get_search_params)
			if request.xhr?
				render partial: 'utauloids/partials/list', locals: { utauloids: @utauloids }, layout: false
			end
		else
			@utauloids = Utauloid.all
		end
	end

	def new
		@utauloid = Utauloid.new
		@categories = Category.all

	end

	def create
		@utauloid = Utauloid.new(utauloid_params)
		@utauloid.creator = current_user
		@utauloid.creator_is_user = @utauloid.creator_name.blank?
		@utauloid.voice_languages << VoiceLanguage.where(id: params[:voice_language_ids])
		@utauloid.voicebank_types << VoicebankType.where(id: params[:voicebank_type_ids])
		@utauloid.voice_characteristics << VoiceCharacteristic.where(id: params[:voice_characteristic_ids])
		if @utauloid.save
			redirect_to new_voice_bank_path(@utauloid)
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

		@utauloid.creator_is_user = utauloid_params[:creator_name].blank? 

		if @utauloid.update_attributes(utauloid_params)
			MessagesService.create_messages({ utauloid_id: @utauloid.id, message_type: "notif_new_update"})
			flash[:success] = "Utauloid successfully updated"
			redirect_to @utauloid
		else
			render 'edit'
		end
	end

	def report
		utauloid = Utauloid.friendly.find(params[:id])

		if utauloid.reports.where(user_id: current_user.id).blank? && utauloid.reports.create(user_id: current_user.id)
			render :json => { status: :ok, message: "Success" }
		else
			render :json => { status: 404 }
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
		@difficulty_vote = DifficultyVote.find_by(user_id: current_user.id, utauloid_id: @utauloid.id)
		if @difficulty_vote.nil?
			@difficulty_vote = @utauloid.difficulty_votes.build
		end
	end

	def get_search_params
		params.permit(:name,
									{ :gender => [] },
									{ :language => [] },
									{ :voicebank_type => [] },
									{ :voice_characteristic => [] },
									:release_date,
									:update_date,
									:creator_name,
									:group)
	end

	def ensure_belonging
		redirect_to(:back) unless Utauloid.friendly.find(params[:id]).uploader == current_user
	end
end	
