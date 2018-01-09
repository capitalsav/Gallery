class LikesController < ApplicationController

  skip_before_action :user_click, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]
  after_action :save_action_like, only: [:create]

  def create
    @image = Image.find(params[:image_id])
    @like = current_user.like_image!(params[:image_id])
    @likes_count = @image.likes.count
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @image = Image.find(params[:image_id])
    current_user.unlike_image(params[:image_id])
    @likes_count = @image.likes.count
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  def save_action_like
    save_user_action(UserAction::ACTION_LIKES)
  end
end
