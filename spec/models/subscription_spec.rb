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
end
