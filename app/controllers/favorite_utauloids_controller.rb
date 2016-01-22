class FavoriteUtauloidsController < ApplicationController
  before_action :ensure_xhr
  before_action :authenticate_user!

  def create
    if FavoriteUtauloid.create!(user_id: current_user.id, utauloid_id: params[:utauloid_id])
      # Sends notifications to the utauloid's creator
      MessagesService.create_messages({ message_type: "notif_new_favorite", utauloid_id: params[:utauloid_id], user_id: current_user.id })
      render :json => { status: :ok, message: "Success" }
    else
      render :json => { status: 400 }
    end
  end

  def destroy
    if FavoriteUtauloid.find_by(user_id: current_user.id, utauloid_id: params[:utauloid_id]).destroy
      render :json => { status: :ok }
    else
      render :json => { status: 400 }
    end
  end

end
