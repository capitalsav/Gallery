# frozen_string_literal: true

# Controller for confirmation users account
class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
  end
end
