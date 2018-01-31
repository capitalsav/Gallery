require 'rails_helper'

RSpec.describe 'Image management', type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
  end

  it 'creates Image and redirects to the Image page' do
    get "/categories/#{@category.id}/new_image"
    expect(response).to render_template(:new)
    path = "/categories/#{@category.id}/create_image"
    post path,
         params: { image: attributes_for(:image,
                                         user_id: @user.id),
                   category_id: @category.id,
                   user_id: @user.id,
                   id: @category.id }
    expect(response).to redirect_to single_category_image_path(
      @category.slug, Image.last.id
    )
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include('<img class=')
  end

  it 'does not render a different template' do
    get "/categories/#{@category.id}/new_image"
    expect(response).to_not render_template(:show)
  end
end
