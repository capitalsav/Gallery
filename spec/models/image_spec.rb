# frozen_string_literal: true

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

  describe '#img' do
    it 'should validate presence' do
      record = Image.new
      record.image = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:image]).to include('can\'t be blank')
      record.image = Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', 'solnce-kosmos-merkuriy.jpg'),
        'image/jpeg'
      )
      record.valid? # run validations
      expect(record.errors[:image]).not_to include('can\'t be blank')
    end
  end
end
