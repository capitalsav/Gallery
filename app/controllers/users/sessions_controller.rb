class Users::SessionsController < Devise::SessionsController
  skip_before_action :user_click, only: [:create, :destroy]
  before_action :save_action_sign_out, only: [:destroy]
  after_action :save_action_sign_in, only: [:create]

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
  def save_action_sign_in
    if user_signed_in?
      save_user_action(UserAction::ACTION_SIGN_IN)
    end
  end

  def save_action_sign_out
    save_user_action(UserAction::ACTION_SIGN_OUT)
  end
end
