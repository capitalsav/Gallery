# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'belong to User' do
    expect(subject).to belong_to(:user).class_name('User')
  end

  it 'has many images' do
    expect(subject).to have_many(:images).dependent(:destroy)
  end

  it 'has many subscriptions' do
    expect(subject).to have_many(:subscriptions).dependent(:destroy)
  end

  it 'has many subscribed users through subscriptions' do
    expect(subject).to have_many(:subscribed_users).through(:subscriptions)
  end

  it 'has many commented categories through images' do
    expect(subject).to have_many(:commented_categories).through(:images)
  end

  it 'has many liked categoties through images' do
    expect(subject).to have_many(:liked_categoties).through(:images)
  end

  it 'validates presence the name ' do
    is_expected.to validate_presence_of(:name)
  end

  it 'validates presence the user_id ' do
    is_expected.to validate_presence_of(:user_id)
  end

  describe '#name' do
    it 'should validate presence' do
      record = Category.new
      record.name = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:name]).to include('can\'t be blank')
      record.name = 'cars' # valid state
      record.valid? # run validations
      expect(record.errors[:name]).not_to include('can\'t be blank')
    end
  end

  describe '#user_id' do
    it 'should validate presence' do
      record = Category.new
      record.user_id = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:user_id]).to include('can\'t be blank')
      record.user_id = 1 # valid state
      record.valid? # run validations
      expect(record.errors[:user_id]).not_to include('can\'t be blank')
    end
  end
end
