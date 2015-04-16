require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {
    FactoryGirl.create :user
  }

  describe 'first name' do
    it 'is required' do
      expect { user.first_name = '' }.to change{ user.valid? }.from(true).to false
    end

    it 'is invalid if length is over 50' do
      expect { user.first_name = 'This name is more than 50 characters and thus is the longest name ever.' }.to change{ user.valid? }.from(true).to false
    end
  end

  describe 'last name' do
    it 'is required' do
      expect { user.last_name = '' }.to change{ user.valid? }.from(true).to false
    end

    it 'is invalid if length is over 50' do
      expect { user.last_name = 'This name is more than 50 characters and thus is the longest name ever.' }.to change{ user.valid? }.from(true).to false
    end
  end

  describe 'username' do
    it 'is required' do
      expect { user.username = '' }.to change{ user.valid? }.from(true).to false
    end

    it 'is invalid if length is over 30' do
      expect { user.username = 'invalidusernamethatistoolongpls' }.to change{ user.valid? }.from(true).to false
    end

    it 'is invalid if it has invalid characters' do
      expect { user.username = "inv' &alid us" }.to change{ user.valid? }.from(true).to false
    end

    it 'is invalid if it is not unique' do
      dup_user = FactoryGirl.build :user, username: user.username
      expect(dup_user.valid?).to be false
    end
  end

  describe 'email' do
    it 'is required' do
      expect { user.email = '' }.to change{ user.valid? }.from(true).to false
    end

    it 'is valid if it is in the correct format' do
      user.email = 'trobb@my-email.com'
      expect(user.valid?).to eq true
    end

    it 'is invalid if it is not in the correct format' do
      expect { user.email = 'm@.&com' }.to change { user.valid? }.from(true).to false
    end
  end

  describe 'password' do
    it 'is invalid if length is less than 8 characters' do
      expect { user.password = 'short' }.to change { user.valid? }.from(true).to false
    end
  end
end
