class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @image = Image.find(params[:image_id])
    @like = current_user.like_image!(params[:image_id])
    @likes_count = @image.likes.count
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
    UserAction.save_user_action(current_user.id, UserAction::ACTION_LIKES, single_category_image_path(@image.category.name))
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
end
