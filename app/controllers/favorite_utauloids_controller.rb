class FavoriteUtauloidsController < ApplicationController
  before_action :ensure_xhr
  before_action :authenticate_user!

  def create
    if FavoriteUtauloid.create(user_id: current_user.id, utauloid_id: params[:utauloid_id])
      render :json => { status: :ok, message: "Success" }
    else
      render :json => { status: 400 }
    end
  end

  def destroy
    FavoriteUtauloid.where(user_id: current_user.id, utauloid_id: params[:utauloid_id]).destroy
  end

end
