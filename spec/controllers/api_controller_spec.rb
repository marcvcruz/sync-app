require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe '#username_uniqueness' do
    before :each do
      controller.instance_variable_set :@current_user, :user
    end
    it 'returns 200 status code for an existing username' do
      get :username_uniqueness, username: user.username
      expect(JSON.parse(response.body)['status']).to be 200
    end
    it 'returns 404 status code for a non-existing username' do
      get :username_uniqueness, username: 'brand_new_user'
      expect(JSON.parse(response.body)['status']).to be 404
    end
  end

end
