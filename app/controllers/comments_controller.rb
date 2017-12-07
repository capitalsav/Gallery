class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create!(image_id: params[:image_id], text: params[:comment][:text])
    image = Image.find(params[:image_id])
    @comments = image.comments.all
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
