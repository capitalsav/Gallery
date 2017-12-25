class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_top_categories
  def get_top_categories
    @top_categories = Category.
        left_outer_joins(:images).distinct.select('categories.*, COUNT(images.*) AS images_count').
        left_outer_joins(:liked_categoties).distinct.select('categories.*, COUNT(likes.*) AS likes_count').
        left_outer_joins(:commented_categories).distinct.select('categories.*, COUNT(comments.*) AS comments_count').
        group('categories.id').order("images_count DESC").order("likes_count DESC").order("comments_count DESC").limit(5)
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password, :avatar])
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_in_path_for(resource_or_scope)
    action_params = {"user_id" => current_user.id, "action_type" => UserAction::ACTION_SIGN_IN, "url" => new_user_session_path}
    puts "=============================0"
    user_action = UserAction.new(action_params)
    user_action.save
    puts "=============================1"
    root_path
  end
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
