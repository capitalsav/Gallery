# frozen_string_literal: true

# Controller for user sign_in, sign_out and for sign_in page
class Users::SessionsController < Devise::SessionsController
  skip_before_action :user_click, only: %i[create destroy]
  before_action :save_action_sign_out, only: :destroy
  after_action :save_action_sign_in, only: :create
  after_action :flash_sign_out, only: :destroy

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
    return unless user_signed_in?
    flash.delete(:notice)
    set_flash_message(:success, :signed_in)
    save_user_action(UserAction::ACTION_SIGN_IN)
  end

  def save_action_sign_out
    save_user_action(UserAction::ACTION_SIGN_OUT)
  end

  def flash_sign_out
    flash.delete(:notice)
    set_flash_message(:success, :signed_out)
  end
end
