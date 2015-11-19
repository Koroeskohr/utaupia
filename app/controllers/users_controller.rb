class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :create, :new]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end


end
