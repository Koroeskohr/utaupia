class UtauloidCommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :utauloid_exists

	def create
		@comment = current_user.utauloid_comments.new(utauloid_comments_params)

		if @comment.save
			redirect_to Utauloid.find(utauloid_comments_params[:utauloid_id])
		else
			redirect_to Utauloid.find(utauloid_comments_params[:utauloid_id]), 
				:flash => { :error => @comment.errors.full_messages.join(', ') }
		end
	end

private
	def utauloid_comments_params
		params.require(:utauloid_comment).permit(:message, :utauloid_id)
	end

	def utauloid_exists
		Utauloid.exists?(id: params[:utauloid_id])
	end
end
