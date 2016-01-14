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
		@utauloid.voice_languages.each do |l|
			if @voice_languages.include?(l)
				@utauloid.voice_languages.delete(l)
			end
		end
		@utauloid.voice_languages << @voice_languages unless @utauloid.voice_languages.include?(@voice_languages)

		if(@utauloid.update_attributes(utauloid_params))
			redirect_to @utauloid
		end
	end

	private
		def utauloid_params
			params.require(:utauloid).permit(:name,
																			:japanese_name,
																			:gender,
																			{ :voice_language_ids => [] },
																			:vb_release_date,
																			:vb_last_update,
																			:creator_name,
																			:wiki_url,
																			:vocadb_url)
		end
end
