require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:standard_user) {
    User.create :standard_user
  }

  it 'redirects unauthorized users to the homepage' do
    standard_user.remember
    cookies.signed[:user_id] = standard_user.id
    cookies.signed[:remember_token] = standard_user.remember_token
    get :index
    expect(response).to redirect_to(root_path)
  end

  describe '#index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assign(:users)).not_to be_empty
    end
  end

  describe '#new' do
    it 'returns http success' do
      get :new
      expect(assigns(:user)).not_to be_nil
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    describe 'with valid parameters' do
      xit 'successfully creates a new user' do

      end

      xit 'redirects to users page' do

      end
    end

    describe 'with invalid parameters' do
      xit 'does not create a new user' do

      end

      xit 'renders the new user page with error messages' do

      end
    end
  end

  describe '#edit' do
    xit 'renders the user edit page for specified user' do

    end
  end

end
