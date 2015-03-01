require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  User.create(first_name:'Taylor', last_name: 'Robb', email: 'trobb@hotmail.com', username: 'trobb', password:'Password1')

  describe 'GET /sign-in' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
      expect(controller.current_user).to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /sign-in with invalid password' do
    it 'does not sign in the user and displays an error message' do
      post :create, session: { username: 'trobb', password: 'Wrong password'}
      expect(response).to have_http_status(:success)
      expect(controller.current_user).to be_nil
      expect(flash.empty?).to_not be true
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /sign-in with valid username and password' do
    it 'signs in user and redirects to root' do
      post :create, session: { username: 'trobb', password: 'Password1' }
      expect(controller.current_user).to_not be_nil
      expect(response).to redirect_to(:root)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete :destroy
      expect(controller.current_user).to be_nil
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
