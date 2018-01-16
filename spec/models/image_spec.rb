require 'rails_helper'

RSpec.describe Image, type: :model do
  it 'belong to Category' do
    expect(subject).to belong_to(:category)
  end

  it 'has many likes' do
    expect(subject).to have_many(:likes).dependent(:destroy)
  end

  it 'has many liking users through likes' do
    expect(subject).to have_many(:liking_users).through(:likes)
  end

  it 'has many comments' do
    expect(subject).to have_many(:comments).dependent(:destroy)
  end

  it 'has many commenting users through comments' do
    expect(subject).to have_many(:commenting_users).through(:comments)
  end
end
