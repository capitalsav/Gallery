# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
  end

  describe 'GET #index' do
    it 'should be successful(NEW)' do
      comment = create(:comment, user_id: @user.id, image_id: @image.id)
      comments = [comment]
      get :index
      expect(assigns(:comments)).to eq(comments)
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    it 'creates category' do
      expect do
        post :create, params: {
          comment: attributes_for(
            :comment,
            user_id: @user.id,
            image_id: @image.id
          ), image_id: @image.id
        }
      end.to change { Comment.count }.by(1) and have_http_status(200)
    end
  end
end
