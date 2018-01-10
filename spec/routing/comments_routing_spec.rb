require 'rails_helper'

RSpec.describe 'routes for Comments', type: :routing do
  it 'routes /comments to comments#index' do
    expect(get: '/comments').to route_to(
      controller: 'comments',
      action: 'index'
    )
  end

  it 'routes /images/:image_id/comments to comments#create' do
    expect(post: '/images/1/comments').to route_to(
      controller: 'comments',
      action: 'create',
      image_id: '1'
    )
  end

  it 'does not match new comments' do
    expect(get: '/comments/new').not_to be_routable
  end

  it 'does not able to patch comments' do
    expect(patch: '/comments').not_to be_routable
  end

  it 'does not able to delete comments' do
    expect(delete: '/comments').not_to be_routable
  end
end
