class DifficultyVotesController < ApplicationController
	before_action :authenticate_user!

	def create
		
	end

	def update

	end

private
	def difficulty_vote_params
		params.require(:difficulty_vote).permit(:note, :utauloid_id)
	end

	def utauloid_exsits
		Utauloid.exists?(id: difficulty_vote_params[:utauloid_id])
	end

	def vote_exists
		DifficultyVote.exists?(id: params[:id], user_id: current_user.id, utauloid_id: difficulty_vote_params[:utauloid_id])
	end
end	
