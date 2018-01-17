require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end

  describe 'GET #home' do
    it 'should be successful(HOME)' do
      top_categories = [@category]
      images = [@image]
      carousel_images = { images_uploaded: true, images: images }
      get :home
      expect(assigns(:top_categories)).to eq(top_categories)
      expect(assigns(:carousel_images)).to eq(carousel_images)
      expect(response).to have_http_status(200)
      expect(response).to render_template('home')
    end
  end
end
