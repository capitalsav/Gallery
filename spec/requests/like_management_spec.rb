# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Like management', type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end

  it 'creates Like ' do
    get "/categories/#{@category.id}/#{@image.id}"
    expect(response).to render_template(:show)
    path = "/images/#{@image.id}/likes"
    expect do
      post path,
           params: { like: attributes_for(:like,
                                          user_id: @user.id,
                                          image_id: @image.id),
                     image_id: @image.id }
    end.to change { Like.count }.by(1) and have_http_status(200)
  end

  it 'destroy Like ' do
    get "/categories/#{@category.id}/#{@image.id}"
    expect(response).to render_template(:show)
    path = "/images/#{@image.id}/likes"
    expect do
      post path,
           params: { like: attributes_for(:like,
                                          user_id: @user.id,
                                          image_id: @image.id),
                     image_id: @image.id }
    end.to change { Like.count }.by(1) and have_http_status(200)

    path = "/images/#{@image.id}/likes/#{Like.last.id}"
    expect do
      delete path,
             params: { category_id: @category.id,
                       image_id: @image.id,
                       id: Like.last.id }
    end.to change(Like, :count).by(-1) and have_http_status(200)
  end

  it 'does not render a different template' do
    get "/categories/#{@category.id}/#{@image.id}"
    expect(response).to_not render_template(:new)
  end
end
