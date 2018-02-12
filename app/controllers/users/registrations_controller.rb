class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  after_action :show_update_notification, only: :update
  after_action :show_create_notification, only: :create

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  def profile
    #TODO remove redundant code @user
    @user = current_user
    UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, profile_path)
  end

  private

  def show_update_notification
    flash.delete(:notice)
    set_flash_message(:success, :updated)
  end

  def show_create_notification
    return unless User.last.email == params[:user][:email]
    flash.delete(:notice)
    set_flash_message(:success, :signed_up_but_unconfirmed)
  end
end
