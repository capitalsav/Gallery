require 'rails_helper'

RSpec.describe 'routes for Likes', type: :routing do
  it 'routes /images/:image_id/likes to likes#create' do
    expect(post: '/images/1/likes').to route_to(
      controller: 'likes',
      action: 'create',
      image_id: '1'
    )
  end

  it 'routes /images/:image_id/likes/:id to likes#destroy' do
    expect(delete: '/images/1/likes/2').to route_to(
      controller: 'likes',
      action: 'destroy',
      image_id: '1',
      id: '2'
    )
  end

  it 'does not match index likes' do
    expect(get: '/likes').not_to be_routable
  end

  it 'does not match new likes' do
    expect(get: '/likes/new').not_to be_routable
  end

  it 'does not able to patch likes' do
    expect(patch: '/likes').not_to be_routable
  end
end
