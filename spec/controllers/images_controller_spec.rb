require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET #new' do
    it 'render new template' do
      category = create(:category, user_id: @user.id)
      get(:new, params: { id: category.id })
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end
end
