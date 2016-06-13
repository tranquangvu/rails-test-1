class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :notice => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |user_params| user_params.permit(:email, :username, :password, :password_confirmation, roles_mask: 2) }
    devise_parameter_sanitizer.for(:account_update) { |user_params| user_params.permit(:email, :username, :avatar, :password, :password_confirmation, :current_password) }
  end
end
