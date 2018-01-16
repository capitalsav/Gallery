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
    expect(@user.likes?(@image)).to eq(@like)
  end

  it 'return subscription if user subscribed on category' do
    expect(@user.subscribed?(@category.id)).to eq(@subscription)
  end
end
