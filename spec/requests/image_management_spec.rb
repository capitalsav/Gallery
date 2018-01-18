require 'rails_helper'

RSpec.describe 'Image management', type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
  end

  it 'creates Image and redirects to the Image page' do
    get "/categories/#{@category.id.to_s}/new_image"
    expect(response).to render_template(:new)
    post "/categories/#{@category.id.to_s}/create_image",
      params: { image: attributes_for(:image, user_id: @user.id),
        category_id: @category.id,
        user_id: @user.id,
        id: @category.id }
    expect(response).to redirect_to single_category_image_path(@category.slug, Image.last.id)
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include('<img src=')
  end

  it 'does not render a different template' do
    get "/categories/#{@category.id.to_s}/new_image"
    expect(response).to_not render_template(:show)
  end
end