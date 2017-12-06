class LikesController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    puts "===================="
    puts params[:image_id]
    puts "===================="
    @like = current_user.like_image!(params[:image_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @image = Image.find(params[:image_id])
    puts "===================="
    puts params[:image_id]
    puts "===================="
    current_user.unlike_image(params[:image_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
