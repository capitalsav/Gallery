require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET #new' do
    it 'render new template' do
      category = create(:category, user_id: @user.id)
      get(:new, params: { id: category.id })
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'creates image' do
      category = create(:category, user_id: @user.id)
      puts @user.id
      expect do
        post :create, params: { image: attributes_for(:image, user_id: @user.id),
                                category_id: category.id,
                                user_id: @user.id,
                                id: category.id,
        }
      end.to change { Image.count }.by(1) and
          redirect_to single_category_image_path(category.slug, Image.last.id) && have_http_status(200) and
          render_template('show')
    end
  end
end