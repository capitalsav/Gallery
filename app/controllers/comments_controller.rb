class CommentsController < ApplicationController

  skip_before_action :user_click, only: [:create]
  before_action :authenticate_user!, only: [:create]
  after_action :save_action_comment, only: [:create]

  def index
    @comments = Comment.joins(:user).order("comments.created_at DESC")
  end

  def create
    current_user.comments.create!(image_id: params[:image_id], text: params[:comment][:text])
    @image = Image.find(params[:image_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  def save_action_comment
    save_user_action(UserAction::ACTION_COMMENTS)
  end
end
