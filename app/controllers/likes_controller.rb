class LikesController < ApplicationController
  def create
    puts "===================="
    puts params[:image_id]
    puts "===================="
    current_user.like_image!(params[:image_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
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
