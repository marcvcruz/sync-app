require 'rails_helper'

RSpec.describe SessionHelper, type: :helper do

  let(:user) {
    User.first
  }

  it 'can sign in a user' do
    sign_in user
    expect(current_user).to_not be_nil
    expect(cookies.signed[:user_id]).to be user.id
  end

  it 'can remember a user' do
    remember user
    expect(cookies.signed[:remember_token]).to eq user.remember_token
  end

  it 'can sign out and forget a user' do
    sign_out
    expect(current_user).to be_nil
    expect(cookies.signed[:user_id]).to be_nil
    expect(cookies.signed[:remember_token]).to be_nil
  end
end
