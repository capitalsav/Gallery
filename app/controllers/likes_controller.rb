class LikesController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @like = current_user.like_image!(params[:image_id])
    @likes_count = @image.likes.count
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
    action_params = {"user_id" => current_user.id, "action_type" => UserAction::ACTION_LIKES, "url" => single_category_image_path(@image.category.name)}
    user_action = UserAction.new(action_params)
    user_action.save
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
