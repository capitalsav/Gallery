require 'rails_helper'

RSpec.describe 'routes for Images', type: :routing do
  it 'routes /images to images#index' do
    expect(get: '/images').to route_to(
      controller: 'images',
      action: 'index'
    )
  end

  it 'routes /categories/:id/:image_id to images#show for id and image_id' do
    expect(get: '/categories/1/2').to route_to(
      controller: 'images',
      action: 'show',
      id: '1',
      image_id: '2'
    )
  end

  it 'routes /categories/:id/new_image to images#new' do
    expect(get: '/categories/1/new_image').to route_to(
      controller: 'images',
      action: 'new',
      id: '1'
    )
  end

  it 'routes /categories/:id/create_image to images#create' do
    expect(post: '/categories/1/create_image').to route_to(
      controller: 'images',
      action: 'create',
      id: '1'
    )
  end

  it 'does not able to patch images' do
    expect(patch: '/images').not_to be_routable
  end

  it 'does not able to delete images' do
    expect(delete: '/images').not_to be_routable
  end
end
