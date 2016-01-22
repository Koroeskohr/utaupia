class DifficultyVotesController < ApplicationController
	before_action :ensure_xhr
	before_action :authenticate_user!
	before_action :utauloid_exists
	before_action :vote_exists, only: [:update]

	def create
		if current_user.difficulty_votes.exists?(utauloid_id: difficulty_vote_params[:utauloid_id])
			if !current_user.difficulty_votes.where(utauloid_id: difficulty_vote_params[:utauloid_id]).destroy
				render :json => { status: 404 }
			end
		end
		@vote = current_user.difficulty_votes.new(difficulty_vote_params)

		if @vote.save
			render :json => { status: :ok, message: "Success" }
		else
			render :json => { status: 404 }
		end
	end

	def update
		@vote = current_user.difficulty_votes.find(params[:id])

		if @vote.update_attributes(difficulty_vote_params)
			render :json => { status: :ok, message: "Success" }
		else
			render :json => { status: 404 }
		end
	end

private
	def difficulty_vote_params
		params.require(:difficulty_vote).permit(:note, :utauloid_id)
	end

	def utauloid_exists
		if !Utauloid.exists?(id: difficulty_vote_params[:utauloid_id])
			render :json => { status: 404 }
		end
	end

	def vote_exists
		if !current_user.difficulty_votes.exists?(id: params[:id])
			render :json => { status: 404 }
		end
	end
end	
