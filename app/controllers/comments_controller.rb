class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def index
    @comments = Comment.joins(:user).order("comments.created_at DESC")
    if user_signed_in?
      UserAction.save_user_action(current_user.id, UserAction::ACTION_NAVIGATION, comments_path)
    end
  end

  def create
    current_user.comments.create!(image_id: params[:image_id], text: params[:comment][:text])
    @comments = Image.find(params[:image_id]).comments
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
    UserAction.save_user_action(current_user.id, UserAction::ACTION_COMMENTS, single_category_image_path(Image.find(params[:image_id]).category.name))
  end
end
