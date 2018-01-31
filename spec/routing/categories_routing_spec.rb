require 'rails_helper'

RSpec.describe 'routes for Categories', type: :routing do
  it 'routes /categories/ to categories#index' do
    expect(get: '/categories/').to route_to(
      controller: 'categories',
      action: 'index'
    )
  end

  it 'routes /categories/:id to categories#show for id' do
    expect(get: '/categories/1').to route_to(
      controller: 'categories',
      action: 'show',
      id: '1'
    )
  end

  it 'routes /categories/new to categories#new' do
    expect(get: '/categories/new').to route_to(
      controller: 'categories',
      action: 'new'
    )
  end

  it 'routes /categories/ to categories#create' do
    expect(post: '/categories').to route_to(
      controller: 'categories',
      action: 'create'
    )
  end

  it 'does not able to patch categories' do
    expect(patch: '/categories').not_to be_routable
  end

  it 'does not able to delete categories' do
    expect(delete: '/categories').not_to be_routable
  end
end
