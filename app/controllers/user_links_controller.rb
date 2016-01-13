class UserLinksController < ApplicationController
	before_action :authenticate_user!
	before_action :fetch_user_link, only: [:update, :destroy]
	before_action :current_user_is_user_post, only: [:create, :update]
	before_action :current_user_is_user, only: [:destroy]

	def create
		@user_link = UserLink.create(user_links_post_params)

		if @user_link.save!
			# Display success message && Refresh user links list
		else
			# Display error message
		end
	end

	def update
		if @user_link.update_attributes(user_links_post_params)
			# Display success message && Refresh user links list
		else
			# Display error message
		end
	end

	def destroy
		if !@user_link.nil? && @user_link.destroy!
			# Display success message && Refresh user links list
		else
			# Display error message
		end
	end

private
	def user_links_post_params
		params.require(:user_link).permit(:user_info_id, :link)
	end

	def fetch_user_link
		@user_link = UserLink.find(params[:id])
	end

	def current_user_is_user_post
		if current_user.user_info.id != params[:user_link][:user_info_id].to_i
			# Display error message && do something
			raise ActionController::RoutingError.new('Not Found')
		end
	end

	def current_user_is_user
		if current_user.user_info.id != @user_link.user_info_id
			# Display error message && do something
			raise ActionController::RoutingError.new('Not Found')
		end
	end
end
