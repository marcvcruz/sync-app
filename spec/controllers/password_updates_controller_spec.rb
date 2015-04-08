require 'rails_helper'

RSpec.describe PasswordUpdatesController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before :each do
    controller.instance_variable_set :@current_user, user
  end

  describe '#edit' do
    it 'renders the change password page' do
      get :edit
      expect(response).to render_template :edit
      expect(response).to have_http_status 200
    end
  end

  describe '#update' do
    context 'with a valid password and password confirmation' do
      it 'updates current user\'s password' do
        old_password = controller.current_user.password
        post :update, password_update: { password: 'New password', password_confirmation: 'New password' }
        expect(controller.current_user.valid?).to be true
        expect(controller.current_user.authenticated?(:password, old_password)).to be false
        expect(controller.current_user.authenticated?(:password, 'New password')).to be true
      end

      it 'redirects to users page' do
        post :update, password_update: { password: 'New password', password_confirmation: 'New password' }
        expect(response).to redirect_to users_path
      end
    end

    context 'with an invalid password' do
      it 'does not update the current user password' do
        old_password = controller.current_user.password
        post :update, password_update: { password: 'Invalid pass', password_confirmation: 'New password' }
        controller.current_user.reload
        expect(controller.current_user.valid?).to be false
        expect(controller.current_user.authenticated?(:password, old_password)).to be true
        expect(controller.current_user.authenticated?(:password, 'Invalid pass')).to be false
      end

      it 'renders the change password page with error messages' do
        post :update, password_update: { password: 'Invalid pass', password_confirmation: 'New password' }
        expect(response).to render_template :edit
      end
    end
  end
end
