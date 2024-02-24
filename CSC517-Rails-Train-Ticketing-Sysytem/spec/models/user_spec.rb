# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a valid email address and password' do
      user = User.new(name:'Tom', email_address: 'test@example.com', password: 'password', address:'3000 Hillsborough st', phone_number:'919-515-3000')
      expect(user).to be_valid
    end

    it 'is not valid without an email address' do
      user = User.new(name:'Tom', password: 'password', address:'3000 Hillsborough st', phone_number:'919-515-3000')
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email address' do
      User.create(email_address: 'test@example.com', password: 'password')
      user = User.new(email_address: 'test@example.com', password: 'password')
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it 'has many bookings' do
      association = described_class.reflect_on_association(:bookings)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many reviews' do
      association = described_class.reflect_on_association(:reviews)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe '#admin?' do
    it 'returns true if the user is an admin' do
      user = User.new(admin: true)
      expect(user.admin?).to eq(true)
    end

    it 'returns false if the user is not an admin' do
      user = User.new(admin: false)
      expect(user.admin?).to eq(false)
    end
  end
end
