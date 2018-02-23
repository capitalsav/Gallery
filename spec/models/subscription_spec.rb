# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it 'belong to User' do
    expect(subject).to belong_to(:user).class_name('User')
  end

  it 'belong to Category' do
    expect(subject).to belong_to(:category).class_name('Category')
  end

  it 'validates presence the category_id ' do
    is_expected.to validate_presence_of(:category_id)
  end

  it 'validates presence the user_id ' do
    is_expected.to validate_presence_of(:user_id)
  end

  describe '#user_id' do
    it 'should validate presence' do
      record = Subscription.new
      record.user_id = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:user_id]).to include('can\'t be blank')
      record.user_id = 1 # valid state
      record.valid? # run validations
      expect(record.errors[:user_id]).not_to include('can\'t be blank')
    end
  end

  describe '#category_id' do
    it 'should validate presence' do
      record = Subscription.new
      record.category_id = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:category_id]).to include('can\'t be blank')
      record.category_id = 1 # valid state
      record.valid? # run validations
      expect(record.errors[:category_id]).not_to include('can\'t be blank')
    end
  end
end
