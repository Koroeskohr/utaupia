class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_is_staff

  def ensure_user_is_staff
    redirect_to :root_path unless current_user && (current_user.administrator? || current_user.moderator?)
  end
  
  def redirect_to_admin(resource)
    redirect_to [:admin, resource]
  end
end
