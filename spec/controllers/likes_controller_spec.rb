require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end

  describe 'POST #create' do
    it 'creates category' do
      expect do
        post :create, params: {
          like: attributes_for(
              :like,
              user_id: @user.id,
              image_id: @image.id
          ), image_id: @image.id
        }
      end.to change { Like.count }.by(1) and have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'delete category' do
      like = create(:like, user_id: @user.id, image_id: @image.id)
      expect do
        delete :destroy,
               params: {
                 category_id: @category.id,
                 image_id: @image.id,
                 id: like.id
               }
      end.to change(Like, :count).by(-1)
      expect(response).to have_http_status(302)
    end
  end
end
