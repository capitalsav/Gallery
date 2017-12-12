class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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
    # @user = current_user
    #
    # avatar = Avatar.new
    # begin
    #   avatar = Avatar.find_by_user_id(current_user.id)
    # rescue ActiveRecord::RecordNotFound
    #   avatar_uploaded = false
    #   default_image = "/assets/default_avatar.png"
    #   #TODO use below for production
    #   #default_image = "default_avatar.png"
    #   default_avatar = Avatar.new(default_image, current_user.id)
    #   @avatar = {:avatar_uploaded => avatar_uploaded, :avatar => default_avatar}
    # else
    #   avatar_uploaded = true
    #   @avatar = {:avatar_uploaded => avatar_uploaded, :avatar => avatar}
    # end


    @user = current_user
    avatar = Avatar.find_by_user_id(current_user.id)
    avatar_uploaded = true
    @new_avatar = Avatar.new
    if avatar.present?
      @avatar = {:avatar_uploaded => avatar_uploaded, :avatar => avatar}
    else
      avatar_uploaded = false
      default_image = "/assets/default_avatar.png"
      #TODO use below for production
      # default_image = "default_avatar.png"
      @avatar = {:avatar_uploaded => avatar_uploaded, :avatar => default_image}
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
