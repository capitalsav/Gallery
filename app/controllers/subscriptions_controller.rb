class SubscriptionsController < ApplicationController

  skip_before_action :user_click, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @category = Category.find(params[:category_id])
    @subscription = current_user.subscribe!(params[:category_id])
    Resque.enqueue(CategoryNotificationJobJob, current_user, @category)
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    current_user.unsubscribe(params[:category_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
