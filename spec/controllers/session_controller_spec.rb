require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  before :all do
    FactoryGirl.create :user, first_name:'Taylor', last_name: 'Robb', email: 'trobb@hotmail.com', username: 'trobb', password:'Password1'
  end

  describe 'GET /sign-in' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status :success
      expect(controller.current_user).to be_nil
      expect(response).to render_template :new
    end
  end

  describe 'POST /sign-in with invalid password' do
    it 'does not sign in the user and displays an error message' do
      post :create, session: { username: 'trobb', password: 'Wrong password'}
      expect(response).to have_http_status :success
      expect(controller.current_user).to be_nil
      expect(cookies.signed[:user_id]).to be_nil
      expect(cookies.signed[:remember_token]).to be_nil
      expect(flash.empty?).to_not be true
      expect(response).to render_template :new
    end
  end

  describe 'POST /sign-in with valid username and password' do
    it 'signs in user and redirects to root' do
      post :create, session: { username: 'trobb', password: 'Password1' }
      expect(controller.current_user).to_not be_nil
      expect(cookies.signed[:user_id]).to_not be_nil
      expect(cookies.signed[:remember_token]).to_not be_nil
      expect(response).to redirect_to :root
    end
  end

  describe 'GET /sign-out' do
    it 'signs out current user and redirects to sign-in page' do
      user = User.first
      user.remember
      cookies.signed[:user_id] = user.id
      cookies.signed[:remember_token] = user.remember_token
      get :destroy
      expect(controller.current_user).to be_nil
      expect(cookies.signed[:user_id]).to be_nil
      expect(cookies.signed[:remember_token]).to be_nil
      expect(response).to redirect_to sign_in_path
    end
  end
end
