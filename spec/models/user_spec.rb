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
      expect(user.errors.messages[:first_name].count).to be 1
    end

    it 'is invalid if length is over 50' do
      user.first_name = 'This name is more than 50 characters and thus is the longest name ever.'
      expect(user.valid?).to be false
      expect(user.errors.messages[:first_name].count).to be 1
    end
  end

  describe 'last name' do
    it 'is required' do
      user.last_name = ''
      expect(user.valid?).to be false
      expect(user.errors.messages[:last_name].count).to be 1
    end

    it 'is invalid if length is over 50' do
      user.last_name = 'This name is more than 50 characters and thus is the longest name ever.'
      expect(user.valid?).to be false
      expect(user.errors.messages[:last_name].count).to be 1
    end
  end

  describe 'username' do
    it 'is required' do
      user.username = ''
      expect(user.valid?).to eq false
      expect(user.errors.messages[:username].count).to be 1
    end

    it 'is invalid if length is over 30' do
      user.username = 'invalidusernamethatistoolongpls'
      expect(user.valid?).to be false
      expect(user.errors.messages[:username].count).to be 1
    end

    it 'is invalid if it has invalid characters' do
      user.username = "inv' &alid us"
      expect(user.valid?).to be false
      expect(user.errors.messages[:username].count).to be 1
    end

    it 'is invalid if it is not unique' do
      user.save
      dup_user = User.new(username: 'trobb')
      expect(dup_user.valid?).to be false
      expect(dup_user.errors.messages[:username].count).to be 1
    end
  end

  describe 'email' do
    it 'is required' do
      user.email = ''
      expect(user.valid?).to eq false
      expect(user.errors.messages[:email].count).to be 1
    end

    it 'is valid if it is in the correct format' do
      user.email = 'trobb@my-email.com'
      expect(user.valid?).to eq true
    end

    it 'is invalid if it is not in the correct format' do
      user.email = 'm@.&com'
      expect(user.valid?).to eq false
      expect(user.errors.messages[:email].count).to be 1
    end
  end

  describe 'password' do
    it 'is required' do
      user = User.new(first_name:'Taylor', last_name:'Robb', username: 'trobb', email: 'trobb@email.com', password: '')
      expect(user.valid?).to eq false
      expect(user.errors.messages[:password].count).to be 2
    end

    it 'is valid if length is between 8 and 30' do
      user.password = 'Good password'
      expect(user.valid?).to eq true
    end

    it 'is invalid if length is less than 8 characters' do
      user.password = 'short'
      expect(user.valid?).to eq false
      expect(user.errors.messages[:password].count).to be 1
    end
  end
end
