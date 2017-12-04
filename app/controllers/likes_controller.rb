class LikesController < ApplicationController
  def create
    puts "======================"
    puts params[:like][:image_id]
    puts "======================"
    current_user.like_image!(params[:like][:image_id])
  end

  def destroy
    puts "======================"
    puts params[:like][:image_id]
    puts "======================"
    current_user.unlike_image(params[:like][:image_id])
  end
end
