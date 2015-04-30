require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'when user is unauthorized' do
    let(:current_user) {
      FactoryGirl.create(:user)
    }

    it 'redirects to the homepage' do
      controller.instance_variable_set :@current_user, current_user
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  context 'when user is authorized' do
    let(:current_user) {
      FactoryGirl.create(:admin)
    }

    before :each do
      controller.instance_variable_set :@current_user, current_user
    end

    describe '#index' do
      it 'displays a list of users' do
        FactoryGirl.create :user
        FactoryGirl.create :user
        FactoryGirl.create :user
        get :index
        expect(assigns(:users).count).to be >= 3
        expect(response).to have_http_status(:success)
      end
    end

    describe '#new' do
      it 'displays the create user page' do
        get :new
        expect(assigns(:user)).not_to be_nil
        expect(response).to have_http_status(:success)
      end
    end

    describe '#create' do
      context 'with valid parameters' do
        let(:user_params) {
          FactoryGirl.attributes_for :user
        }

        before :each do
          post :create, user: user_params
        end

        it 'successfully creates a new user' do
          expect(User.find_by_username(user_params[:username])).not_to be_nil
        end

        it 'redirects to users page' do
          expect(response).to redirect_to users_path
        end
      end

      context 'with invalid parameters' do
        let(:user_params) {
          user_hash = FactoryGirl.attributes_for(:user)
          user_hash.delete :email
          user_hash
        }

        before :each do
          post :create, user: user_params
        end

        it 'does not create a new user' do
          user = assigns(:user)
          expect(user.valid?).to eq false
          expect(user.persisted?).to eq false
        end

        it 'renders the new user page' do
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#edit' do
      let(:user) {
        FactoryGirl.create :user
      }

      it 'renders the user edit page for user' do
        get :edit, id: user.id
        expect(assigns(:user)).to eq user
        expect(response).to render_template(:edit)
      end
    end

    describe '#update' do
      context 'with valid parameters' do
        let(:user) {
          FactoryGirl.create :user
        }

        before :each do
          put :update, id: user.id, user: { first_name: 'Mellow' }
        end

        it 'updates the user\'s information' do
          updated_user = User.find(user.id)
          expect(updated_user).not_to be_nil
          expect(updated_user.first_name).to eq 'Mellow'
        end

        it 'redirects to the users page' do
          expect(response).to redirect_to users_path
        end
      end

      context 'with invalid parameters' do
        let(:user) {
          FactoryGirl.create :user
        }

        before :each do
          put :update, id: user.id, user: { email: nil }
        end

        it 'does not update the user\'s information' do
          expect(assigns(:user).valid?).to eq false
          expect(User.find(user.id).email).not_to be_nil
        end

        it 'renders the edit user page' do
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
