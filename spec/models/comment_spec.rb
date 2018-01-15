require 'rails_helper'

RSpec.describe Comment, type: :model do
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
end
