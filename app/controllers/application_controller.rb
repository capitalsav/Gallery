# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, only: Proc.new { |c| c.request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_top_categories
  before_action :set_locale
  before_action :user_click

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
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

  def save_user_action(action_type)
    UserAction.save_user_action(current_user.id,  action_type, request.original_url)
  end

  private
  def user_click
    UserAction.save_user_action(current_user.id,  UserAction::ACTION_NAVIGATION, request.original_url) if user_signed_in?
  end
end
