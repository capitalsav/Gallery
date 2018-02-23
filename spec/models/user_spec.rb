# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has many images' do
    expect(subject).to have_many(:images).dependent(:destroy)
  end

  it 'has many categories' do
    expect(subject).to have_many(:categories).dependent(:destroy)
  end

  it 'has many likes' do
    expect(subject).to have_many(:likes).dependent(:destroy)
  end

  it 'has many liked images through likes' do
    expect(subject).to have_many(:liked_images).through(:likes)
  end

  it 'has many comments' do
    expect(subject).to have_many(:comments).dependent(:destroy)
  end

  it 'has many commented images through comments' do
    expect(subject).to have_many(:commented_images).through(:comments)
  end

  it 'has many subscriptions' do
    expect(subject).to have_many(:subscriptions).dependent(:destroy)
  end

  it 'has many subscribed categories through subscription' do
    expect(subject).to have_many(:subscribed_categories).through(:subscriptions)
  end

  it 'has many user actions' do
    expect(subject).to have_many(:user_actions).dependent(:destroy)
  end

  before do
    @user = create(:user)
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
    @like = create(:like, user_id: @user.id, image_id: @image.id)
    @subscription = create(
      :subscription,
      user_id: @user.id,
      category_id: @category.id
    )
  end

  it 'return like if user liked image' do
    expect(@user.likes(@image)).to eq(@like)
  end

  it 'return subscription if user subscribed on category' do
    expect(@user.subscribed(@category.id)).to eq(@subscription)
  end

  describe '#email' do
    it 'should validate presence' do
      record = User.new
      record.email = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:email]).to include('can\'t be blank')
      record.email = 'test@test.com' # valid state
      record.valid? # run validations
      expect(record.errors[:email]).not_to include('can\'t be blank')
    end
  end

  describe '#password' do
    it 'should validate presence' do
      record = User.new
      record.email = 'test@test.com' # invalid state
      record.encrypted_password = ''
      record.valid? # run validations
      expect(record.errors[:encrypted_password]).to include('can\'t be blank')
      record.email = 'test@test.com' # valid state
      record.encrypted_password = '123456'
      record.valid? # run validations
      expect(record.errors[:encrypted_password])
        .not_to include('can\'t be blank')
    end

    it 'should validate length' do
      record = User.new
      record.email = 'test@test.com' # invalid state
      record.encrypted_password = '1234'
      record.valid? # run validations
      expect(record.errors[:encrypted_password])
        .to include('is too short (minimum is 6 characters)')
      record.email = 'test@test.com' # valid state
      record.encrypted_password = '123456'
      record.valid? # run validations
      expect(record.errors[:encrypted_password])
        .not_to include('is too short (minimum is 6 characters)')
    end
  end
end
