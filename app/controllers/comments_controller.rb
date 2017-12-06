class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build()
    if @comment.save
      # flash[:success] = "Micropost created!"
      # redirect_to root_url
    else
      # @feed_items = []
      # render 'static_pages/home'
    end
  end
end
