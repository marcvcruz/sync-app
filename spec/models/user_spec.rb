require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    User.new(
      first_name:'Taylor',
      last_name:'Robb',
      username: 'trobb',
      email:'trobb@gmail.com',
      password: 'This is a valid password!'
    )
  }

  it 'created from valid attributes is valid' do
    expect(user.valid?).to be true
  end

  describe 'first name' do
    it 'is required' do
      user.first_name = ''
      expect(user.valid?).to be false
    end

    it 'is invalid if length is over 50' do
      user.first_name = 'This name is more than 50 characters and thus is the longest name ever.'
      expect(user.valid?).to be false
    end
  end

  describe 'last name' do
    it 'is required' do
      user.last_name = ''
      expect(user.valid?).to be false
    end

    it 'is invalid if length is over 50' do
      user.last_name = 'This name is more than 50 characters and thus is the longest name ever.'
      expect(user.valid?).to be false
    end
  end

  describe 'username' do
    it 'is required' do
      user.username = ''
      expect(user.valid?).to eq false
    end

    it 'is invalid if length is over 10' do
      user.username = 'This username is more than 10 characters.'
      expect(user.valid?).to be false
    end

    it 'is invalid if it has invalid characters' do
      user.username = "inv' &alid us"
      expect(user.valid?).to be false
    end

    it 'is invalid if it is not unique' do
      user.save
      dup_user = User.new(username: 'trobb@gmail.com')
      expect(dup_user.valid?).to be false
    end
  end

  describe 'email' do
    it 'is required' do
      user.email = ''
      expect(user.valid?).to eq false
    end

    it 'is invalid if it is not in the correct format' do
      user.email = 'm@.&com'
      expect(user.valid?).to eq false
    end

    it 'is valid if it is in the correct format' do
      user.email = 'trobb@my-email.com'
      expect(user.valid?).to eq true
    end
  end

  describe 'password' do
    it 'is required' do
      user = User.new(first_name:'Taylor', last_name:'Robb', username: 'trobb', email: 'trobb@email.com', password: '')
      expect(user.valid?).to eq false
    end

    it 'is invalid if length is less than 8 characters' do
      user = User.new(first_name:'Taylor', last_name:'Robb', username: 'trobb', email: 'trobb@email.com', password: 'short')
      expect(user.valid?).to eq false
    end

    it 'is invalid if length is greater than 30 characters' do
      user = User.new(first_name:'Taylor', last_name:'Robb', username: 'trobb', email: 'trobb@email.com', password: 'This is too long of a password to use effectively This is too long of a password to use effectively')
      expect(user.valid?).to eq false
    end
  end
end
