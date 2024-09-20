# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create
    resource = User.find_by(username: params[:user][:username])
    if resource && resource.valid_password?(params[:user][:password])
      sign_in(resource_name, resource)
      redirect_to root_path
    else
      flash[:alert] = 'Invalid username or password.'
      redirect_to new_user_session_path
    end
  end
  

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
