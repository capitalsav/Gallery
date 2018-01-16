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

  describe '#user_id' do
    it 'should validate presence' do
      record = UserAction.new
      record.user_id = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:user_id]).to include('can\'t be blank')
      record.user_id = 1 # valid state
      record.valid? # run validations
      expect(record.errors[:user_id]).not_to include('can\'t be blank')
    end
  end

  describe '#action_type' do
    it 'should validate presence' do
      record = UserAction.new
      record.action_type = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:action_type]).to include('can\'t be blank')
      record.action_type = 'test' # valid state
      record.valid? # run validations
      expect(record.errors[:action_type]).not_to include('can\'t be blank')
    end
  end

  describe '#url' do
    it 'should validate presence' do
      record = UserAction.new
      record.url = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:url]).to include('can\'t be blank')
      record.url = 'test' # valid state
      record.valid? # run validations
      expect(record.errors[:url]).not_to include('can\'t be blank')
    end
  end
end
