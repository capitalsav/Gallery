# Controller to perform actions sign-in sign-out
class Users::SessionsController < Devise::SessionsController
  before_action :recaptcha_check, only: :create
  after_action :user_log_in, only: :create
  before_action :user_sign_out, only: :destroy

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
    super
  end

  private

  def user_log_in
    return unless current_user
    UserAction.save_user_action(current_user.id,
                                UserAction::ACTION_SIGN_IN,
                                new_user_session_path)
    cookies[:login_attempts] = 0
  end

  def user_sign_out
    UserAction.save_user_action(current_user.id,
                                UserAction::ACTION_SIGN_OUT,
                                UserAction::PATH_SIGN_OUT)
  end

  def recaptcha_check
    cookies[:login_attempts] ||= 0
    cookies[:login_attempts] = cookies[:login_attempts].to_i + 1
    return unless cookies[:login_attempts].to_i > 3
    unless verify_recaptcha
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.js
      end
    end
  end
end
