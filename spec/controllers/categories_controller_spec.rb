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
end
