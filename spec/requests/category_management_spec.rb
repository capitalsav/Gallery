require 'rails_helper'

RSpec.describe 'Category management', type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  it 'creates a Category and redirects to the Category page' do
    get '/categories/new'
    expect(response).to render_template(:new)
    post '/categories', params: {
      category: attributes_for(:category, user_id: @user.id)
    }
    expect(response).to redirect_to(assigns(:category))
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include(Category.last.name)
  end

  it 'does not render a different template' do
    get '/categories/new'
    expect(response).to_not render_template(:show)
  end
end