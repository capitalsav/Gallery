require 'rails_helper'

RSpec.describe 'Comment management', type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end

  it 'creates a Comment ' do
    get "/categories/#{@category.id}/#{@image.id}"
    expect(response).to render_template(:show)
    path = "/images/#{@image.id}/comments"
    expect do
      post path,
           params: { comment: attributes_for(:comment,
                                             user_id: @user.id,
                                             image_id: @image.id),
                     image_id: @image.id }
    end.to change { Comment.count }.by(1) and have_http_status(200)
  end

  it 'does not render a different template' do
    get "/categories/#{@category.id}/#{@image.id}"
    expect(response).to_not render_template(:new)
  end
end
