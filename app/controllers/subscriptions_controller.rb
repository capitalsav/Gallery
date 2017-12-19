class SubscriptionsController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
    @subscription = current_user.subscribe!(params[:category_id])
    # CategoryMailer.subscribe_email(current_user, @category)
    CategoryMailer.subscribe_email(current_user, @category).deliver
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
