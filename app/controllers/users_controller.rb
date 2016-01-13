class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :new]

  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
  end


end
