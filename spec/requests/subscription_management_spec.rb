# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subscription management', type: :request do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
  end

  it 'creates a Subscription on Category' do
    get categories_path
    expect(response).to render_template(:index)

    path = "/categories/#{@category.id}/subscriptions"
    expect do
      post path,
           params: { subscription: attributes_for(:subscription,
                                                  user_id: @user.id,
                                                  category_id: @category.id),
                     category_id: @category.id }
    end.to change { Subscription.count }.by(1) and have_http_status(200)
  end

  it 'destroy a Subscription on Category' do
    get categories_path
    expect(response).to render_template(:index)

    path = "/categories/#{@category.id}/subscriptions"
    expect do
      post path,
           params: { subscription: attributes_for(:subscription,
                                                  user_id: @user.id,
                                                  category_id: @category.id),
                     category_id: @category.id }
    end.to change { Subscription.count }.by(1) and have_http_status(200)

    path = "/categories/#{@category.id}/subscriptions/#{Subscription.last.id}"
    expect do
      delete path,
             params: { category_id: @category.id,
                       id: Subscription.last.id }
    end.to change { Subscription.count }.by(-1) and have_http_status(200)
  end

  it 'does not render a different template' do
    get categories_path
    expect(response).to_not render_template(:new)
  end
end
