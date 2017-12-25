class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    action_params = {"user_id" => current_user.id, "action_type" => UserAction::ACTION_SIGN_OUT, "url" => UserAction::PATH_SIGN_OUT}
    puts "=============================0"
    user_action = UserAction.new(action_params)
    user_action.save
    puts "=============================1"
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
