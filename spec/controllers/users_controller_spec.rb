require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'when user is unauthorized' do
    let(:current_user) {
      FactoryGirl.create(:user)
    }

    it 'redirects unauthorized users to the homepage' do
      current_user.remember
      cookies.signed[:user_id] = current_user.id
      cookies.signed[:remember_token] = current_user.remember_token
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  context 'when user is authorized' do
    let(:current_user) {
      FactoryGirl.create(:admin)
    }

    before :each do
      current_user.remember
      cookies.signed[:user_id] = current_user.id
      cookies.signed[:remember_token] = current_user.remember_token
    end

    describe '#index' do
      it 'returns http success' do
        get :index
        expect(assigns(:users)).not_to be_empty
        expect(response).to have_http_status(:success)
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
end
