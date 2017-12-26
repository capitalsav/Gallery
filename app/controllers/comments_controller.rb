class CommentsController < ApplicationController

  def index
    @comments = Comment.joins(:user).order("comments.created_at DESC")
    if user_signed_in?
      UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, comments_path)
    end
  end

  def create
    # OPTIMIZE try to make it with joins
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
    if user_signed_in?
      UserAction.save_user_action(current_user.id, UserAction::ACTION_COMMENT, single_category_image_path(@comment.image.category.name))
    end
  end
end
