class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :new]
  before_action :fetch_user, only: [:show, :edit, :update]
  before_action :current_user_is_user_post, only: [:update]
  before_action :current_user_is_user, only: [:edit]

  def index
    @users = User.all
  end

  def show

  end

  def edit
    1.times { @user.user_info.user_links.build }
  end

  def update
  	@user.update!(user_params)
    redirect_to edit_user_path(@user)
  end

private
  def user_params
		params.require(:user).permit(:id, :nickname,
			:user_info_attributes => [:id, :description, :favorites_are_showable, :utauloids_are_showable, :notif_when_vb_updated, :notif_when_utauloid_faved, :notif_when_utauloid_commented,
				:user_links_attributes => [:id, :link, :_destroy]
			]
		)
  end

  def fetch_user
    @user = User.friendly.find(params[:id])
  end

  def current_user_is_user_post
    if current_user != User.friendly.find(params[:id])
      # Display error message && do something
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def current_user_is_user
    if current_user != @user
      # Display error message && do something
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
