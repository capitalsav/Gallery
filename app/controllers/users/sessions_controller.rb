class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    if user_signed_in?
      UserAction.save_user_action(current_user.id,  UserAction::ACTION_SIGN_IN, new_user_session_path)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    UserAction.save_user_action(current_user.id,  UserAction::ACTION_SIGN_OUT, UserAction::PATH_SIGN_OUT)
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
