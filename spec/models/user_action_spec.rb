require 'rails_helper'

RSpec.describe UserAction, type: :model do

  before(:each) do
    @user = create(:user)
    @url = 'http://localhost/categories'
  end

  it 'belong to User' do
    expect(subject).to belong_to(:user).class_name('User')
  end

  it 'validates presence the user_id ' do
    is_expected.to validate_presence_of(:user_id)
  end

  it 'save user action navigation' do
    expect do
      UserAction::save_user_action(@user.id, UserAction::ACTION_NAVIGATION, @url)
    end.to change { UserAction.count }.by(1)
  end

  it 'save user action sign in' do
    expect do
      UserAction::save_user_action(@user.id, UserAction::ACTION_SIGN_IN, @url)
    end.to change { UserAction.count }.by(1)
  end

  it 'save user action sign out' do
    expect do
      UserAction::save_user_action(@user.id, UserAction::ACTION_SIGN_OUT, @url)
    end.to change { UserAction.count }.by(1)
  end

  it 'save user action likes' do
    expect do
      UserAction::save_user_action(@user.id, UserAction::ACTION_LIKES, @url)
    end.to change { UserAction.count }.by(1)
  end

  it 'save user action comments' do
    expect do
      UserAction::save_user_action(@user.id, UserAction::ACTION_COMMENTS, @url)
    end.to change { UserAction.count }.by(1)
  end
end
