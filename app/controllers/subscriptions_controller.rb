class SubscriptionsController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
    @subscription = current_user.subscribe!(params[:category_id])
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    current_user.unsubscribe(params[:category_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end

# def create
#   @image = Image.find(params[:image_id])
#   @like = current_user.like_image!(params[:image_id])
#   @likes_count = @image.likes.count
#   respond_to do |format|
#     format.html { redirect_to :back }
#     format.js
#   end
# end

# def destroy
#   @image = Image.find(params[:image_id])
#   current_user.unlike_image(params[:image_id])
#   @likes_count = @image.likes.count
#   respond_to do |format|
#     format.html { redirect_to :back }
#     format.js
#   end
# end