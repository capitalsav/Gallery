class CommentsController < ApplicationController

  def index
    @comments = Comment.joins(:user).order("comments.created_at DESC")
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
    action_params = {"user_id" => current_user.id, "action_type" => UserAction::ACTION_COMMENT, "url" => single_category_image_path(@comment.image.category.name)}
    user_action = UserAction.new(action_params)
    user_action.save
  end
end
