class DifficultyVotesController < ApplicationController
	before_action :authenticate_user!
	before_action :utauloid_exists
	before_action :vote_exists, only: [:update]

	def create
		@vote = current_user.difficulty_votes.new(difficulty_vote_params)

		if @vote.save
			redirect_to Utauloid.find(difficulty_vote_params[:utauloid_id])
		else
			raise ActionController::RoutingError.new('Not Found')
		end
	end

	def update
		@vote = current_user.difficulty_votes.find(params[:id])

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

	def utauloid_exists
		if !Utauloid.exists?(id: difficulty_vote_params[:utauloid_id])
			raise ActionController::RoutingError.new('Not Found')
		end
	end

	def vote_exists
		if !current_user.difficulty_votes.exists?(id: params[:id])
			raise ActionController::RoutingError.new('Not Found')
		end
	end
end	
