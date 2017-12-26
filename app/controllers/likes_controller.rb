class LikesController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @like = current_user.like_image!(params[:image_id])
    @likes_count = @image.likes.count
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
    if user_signed_in?
      UserAction.save_user_action(current_user.id, UserAction::ACTION_LIKES, single_category_image_path(@image.category.name))
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
end
