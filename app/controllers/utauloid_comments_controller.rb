class UtauloidCommentsController < ApplicationController
	before_action :ensure_xhr, only: [:edit, :update]
	before_action :authenticate_user!
	before_action :utauloid_exists, only: [:create]

	def create
		@comment = current_user.utauloid_comments.new(utauloid_comments_params)

		if @comment.save
			MessagesService.create_messages({ message_type: "notif_new_comment", utauloid_id: utauloid_comments_params[:utauloid_id], user_id: current_user.id })
			redirect_to Utauloid.find(utauloid_comments_params[:utauloid_id])
		else
			redirect_to Utauloid.find(utauloid_comments_params[:utauloid_id]), flash: { error: @comment.errors.full_messages.first }
		end
	end

	def edit
		@comment = current_user.utauloid_comments.find(utauloid_comments_edit_params[:id])

		if @comment.blank?
			render :json => { status: 400 }
		else
			render partial: 'utauloid_comments/partials/edit', locals: { comment: @comment }, layout: false
		end
	end

	def update
		@comment = current_user.utauloid_comments.find(utauloid_comments_edit_params[:id])

		if @comment.blank?
			render :json => { status: 400 }
		else
			if @comment.update_attributes(utauloid_comments_update_params)
				render partial: 'utauloid_comments/partials/show', locals: { comment: @comment }, layout: false
			else
				render :json => { status: 400 }
			end
		end
	end

private
	def utauloid_comments_edit_params
		params.permit(:id)
	end

	def utauloid_comments_update_params
		params.require(:utauloid_comment).permit(:message)
	end

	def utauloid_comments_params
		params.require(:utauloid_comment).permit(:message, :utauloid_id)
	end

	def utauloid_exists
		if !Utauloid.exists?(id: utauloid_comments_params[:utauloid_id])
			raise ActionController::RoutingError.new('Not Found')
		end
	end
end
