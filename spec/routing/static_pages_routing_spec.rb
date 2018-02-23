# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'routes for Static pages', type: :routing do
  it 'routes / to static_pages#home' do
    expect(get: '/').to route_to(
      controller: 'static_pages',
      action: 'home'
    )
  end

  it 'does not able to patch root path' do
    expect(patch: '/images').not_to be_routable
  end

  it 'does not able to delete root path' do
    expect(delete: '/images').not_to be_routable
  end
end
