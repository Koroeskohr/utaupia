class UtauloidCommentsController < ApplicationController
	before_action :authenticate_user!


private
	def utauloid_comments_params
		params.require(:utauloid_comment).permit(:message, :utauloid_id)
	end

	def utauloid_exsits
		Utauloid.exists?(id: utauloid_comments_params[:utauloid_id])
	end
end
