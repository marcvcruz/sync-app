require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  let(:user) { FactoryGirl.create :user }

  describe '#new' do
    it 'returns http success' do
      get :new
      expect(response).to render_template :new
      expect(response).to have_http_status :success
    end
  end

  describe '#create' do
    it 'returns http success' do
      post :create, password_reset: { username: user.username }
      expect(response).to have_http_status :success
      expect(assigns(:user)).to eql user
    end
  end

  describe '#edit' do
    before :each do
      user.create_reset_digest
    end

    context 'with a valid reset token' do
      it 'returns http success' do
        get :edit, token: user.reset_token, username: user.username
        expect(response).to have_http_status :success
      end
    end

    context 'with an expired reset token' do
      before :each do
        user.update_attribute :reset_sent_at, 5.days.ago
      end

      it 'redirects to //forgot-password' do
        get :edit, token: user.reset_token, username: user.username
        expect(response).to redirect_to new_password_reset_url
      end
    end
  end

  describe '#update' do
    before :each do
      user.create_reset_digest
    end

    it 'redirects to homepage' do
      old_password = user.password
      put :update, token: user.reset_token, username: user.username, user: { password: 'New Password', password_confirmation: 'New Password' }
      expect(controller.current_user).to eql user
      expect(controller.current_user.authenticated?(:password, old_password)).to be false
      expect(controller.current_user.authenticated?(:password, 'New Password')).to be true
      expect(response).to redirect_to root_path
    end
  end

end
