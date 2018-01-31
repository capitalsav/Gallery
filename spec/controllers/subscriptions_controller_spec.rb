require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end

  describe 'POST #create' do
    it 'creates subscription' do
      expect do
        post :create, params: {
          subscription: attributes_for(
            :subscription,
            user_id: @user.id,
            category_id: @category.id
          ), category_id: @category.id
        }
      end.to change { Subscription.count }.by(1) and have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'delete subscription' do
      subscription = create(
        :subscription, user_id: @user.id, category_id: @category.id
      )
      expect do
        delete :destroy,
               params: {
                 category_id: @category.id,
                 id: subscription.id
               }
      end.to change(Subscription, :count).by(-1)
      expect(response).to have_http_status(302)
    end
  end
end
