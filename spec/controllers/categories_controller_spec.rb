require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET #new' do
    it 'should be successful(NEW)' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'creates category' do
      expect do
        post :create, params: {
          category: attributes_for(:category, user_id: @user.id)
        }
      end.to change { Category.count }.by(1) and
        redirect_to Category.last && have_http_status(200) and
        render_template('show')
    end
  end

  describe 'GET #index' do
    it 'assigns @categories_with_images' do
      category = create(:category, user_id: @user.id)
      image = create(:image, user_id: @user.id, category_id: category.id)
      categories_with_images = [{category_key: category, image_key: image}]
      get :index
      expect(assigns(:categories_with_images)).to eq(categories_with_images)
    end

    it 'render index template' do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end
end
