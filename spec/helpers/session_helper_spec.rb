require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionHelper. For example:
#
# describe SessionHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
