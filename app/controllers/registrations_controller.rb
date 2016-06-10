class RegistrationsController < Devise::RegistrationsController

  protected

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :avatar, :password, :password_confirmation, :current_password)
  end
end
