class UserLinksController < ApplicationController
	include UrlHelper

	before_action :authenticate_user!
	before_action :fetch_user_link, only: [:update, :destroy]

	before_save :add_protocol_to_url


	def create
		if @user_link = current_user.user_info.user_links.create(user_links_post_params)
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
		@user_link = current_user.user_info.user_links.find(params[:id])
	end

	def add_protocol_to_url
		@user_link.link = url_with_protocol(@user_link.link)
	end
end
