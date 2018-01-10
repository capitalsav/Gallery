require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe '#email' do
    it 'should validate presence' do
      record = AdminUser.new
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
      record = AdminUser.new
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
      record = AdminUser.new
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
