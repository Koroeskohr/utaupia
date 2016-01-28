class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :banned?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from NoMethodError, with: :not_found

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nickname, :password, :password_confirmation, :current_password) }
  end

  def ensure_xhr
    redirect_to :root_path unless request.xhr?
  end

  def ensure_admin
    redirect_to :root_path unless current_user.administrator? || current_user.moderator?
  end

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "This account has been suspended."
      redirect_to :root_path
    end
  end

  def not_found
    message = "An unexpected error happened"
    logger.error message
    redirect_to utauloids_path, :flash => { :error => message }
  end

end
