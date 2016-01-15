class UtauloidCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		raise ActionController::RoutingError.new('Not Found') unless utauloid_exsits
		
		@comment = UtauloidComment.new(utauloid_comments_params)
		@comment.user = current_user

		if @comment.save
			redirect_to Utauloid.find(utauloid_comments_params[:utauloid_id])
		else
			raise ActionController::RoutingError.new('Not Found')
		end
	end

private
	def utauloid_comments_params
		params.require(:utauloid_comment).permit(:message, :utauloid_id)
	end

	def utauloid_exsits
		Utauloid.exists?(id: utauloid_comments_params[:utauloid_id])
	end
end
