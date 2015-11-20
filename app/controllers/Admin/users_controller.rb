class Admin::UsersController < Admin::AdminController
  before_action :fetch_user, only: [:edit, :show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    @user = User.new(admin_user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(admin_user_params)
      redirect_to_admin @user
    end
  end

  def destroy
    @user.destroy
    redirect_to_admin admin_users_path
  end


private
  def admin_user_params
    params.require(:user).permit(:nickname, :email, :role)
  end

  def fetch_user
    @user = User.find(params[:id])
  end 

  def redirect_to_admin(resource)
    redirect_to [:admin, resource]
  end
end
