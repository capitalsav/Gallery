# frozen_string_literal: true

class CommentsController < ApplicationController

  skip_before_action :user_click, only: [:create]
  before_action :authenticate_user!, only: [:create]
  after_action :save_action_comment, only: [:create]

  def index
    @comments = Comment.joins(:user).order('comments.created_at DESC')
  end

  def create
    @image = Image.find(params[:image_id])
    current_user.comments.create!(image_id: @image.id,
                                  text: params[:comment][:text])
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js
    end
  end

  private

  def save_action_comment
    save_user_action(UserAction::ACTION_COMMENTS)
  end
end
