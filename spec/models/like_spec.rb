require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'belong to User' do
    expect(subject).to belong_to(:user).class_name('User')
  end

  it 'belong to Image' do
    expect(subject).to belong_to(:image).class_name('Image')
  end

  it 'validates presence the image_id ' do
    is_expected.to validate_presence_of(:image_id)
  end

  it 'validates presence the user_id ' do
    is_expected.to validate_presence_of(:user_id)
  end

  describe '#user_id' do
    it 'should validate presence' do
      record = Like.new
      record.user_id = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:user_id]).to include('can\'t be blank')
      record.user_id = 1 # valid state
      record.valid? # run validations
      expect(record.errors[:user_id]).not_to include('can\'t be blank')
    end
  end

  describe '#image_id' do
    it 'should validate presence' do
      record = Like.new
      record.image_id = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:image_id]).to include('can\'t be blank')
      record.image_id = 1 # valid state
      record.valid? # run validations
      expect(record.errors[:image_id]).not_to include('can\'t be blank')
    end
  end
end
