require 'rails_helper'

describe ValidationHelper do
  let(:user) {
    FactoryGirl.create :user
  }

  describe '#error_exists?' do
    context 'for a user with a valid email' do
      it 'returns false' do
        expect(helper.error_exists? user, :email).to be false
      end
    end

    context 'for a user with an invalid email' do
      before :each do
        user.email = 'invalid@email'
      end

      it 'returns true' do
        expect(helper.error_exists? user, :email).to be true
      end
    end
  end

  describe '#error_message_for' do
    context 'for a user with a valid email' do
      it 'does not return an error message' do
        expect(helper.error_message_for user, :email).to be_nil
      end
    end

    context 'for a user with an invalid email' do
      before :each do
        user.email = 'invalid@email'
      end

      it 'returns an error message' do
        expect(helper.error_message_for user, :email).to_not be_nil
      end
    end
  end
end