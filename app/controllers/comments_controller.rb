class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create!(image_id: params[:image_id], text: params[:comment][:text])
    # if @comment.save
    #   puts "============save"
    #   # flash[:success] = "Micropost created!"
    #   # redirect_to root_url
    # else
    #   puts "=========notSave"
    #   # @feed_items = []
    #   # render 'static_pages/home'
    # end
  end
end
