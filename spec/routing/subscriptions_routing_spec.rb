# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'routes for Subscriptions', type: :routing do
  it 'routes /categories/:category_id/subscriptions to subscriptions#create' do
    expect(post: '/categories/1/subscriptions').to route_to(
      controller: 'subscriptions',
      action: 'create',
      category_id: '1'
    )
  end

  it 'routes /categories/:category_id/subscriptions/:id
        to subscriptions#destroy' do
    expect(delete: '/categories/1/subscriptions/2').to route_to(
      controller: 'subscriptions',
      action: 'destroy',
      category_id: '1',
      id: '2'
    )
  end

  it 'does not match index subscriptions' do
    expect(get: '/subscriptions').not_to be_routable
  end

  it 'does not match new subscriptions' do
    expect(get: '/subscriptions/new').not_to be_routable
  end

  it 'does not able to patch subscriptions' do
    expect(patch: '/subscriptions').not_to be_routable
  end
end
