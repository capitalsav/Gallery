# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  context 'with valid google credentials' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[
        :google_oauth2
      ] = OmniAuth::AuthHash.new provider: :google_oauth2,
                                 uid: '1234',
                                 info: { email: 'test@gmail.com' }
    end

    it 'creates a new user' do
      expect do
        visit user_google_oauth2_omniauth_callback_path
      end.to change(User, :count).by(1)
    end
  end
end
