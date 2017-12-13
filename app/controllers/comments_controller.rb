class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create!(image_id: params[:image_id], text: params[:comment][:text])
    image = Image.find(params[:image_id])
    # @comments = image.comments.all
    comments = image.comments.all
    @comments_with_users = []
    comments.each do |comment|
      my_hash = {}
      my_hash["comment"] = comment
      my_hash["user"] = comment.user
      @comments_with_users.push(my_hash)
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
