class DifficultyVotesController < ApplicationController
	before_action :authenticate_user!

	def create
		raise ActionController::RoutingError.new('Not Found') unless utauloid_exsits

		@vote = DifficultyVote.new(difficulty_vote_params)
		@vote.user = current_user

		if @vote.save
			redirect_to Utauloid.find(difficulty_vote_params[:utauloid_id])
		else
			raise ActionController::RoutingError.new('Not Found')
		end
	end

	def update
		raise ActionController::RoutingError.new('Not Found') unless utauloid_exsits && vote_exists

		@vote = DifficultyVote.find(params[:id])

		if @vote.update_attributes(difficulty_vote_params)
			redirect_to Utauloid.find(difficulty_vote_params[:utauloid_id])
		else
			raise ActionController::RoutingError.new('Not Found')
		end
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
