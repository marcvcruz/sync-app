require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
      expect(current_user).to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #create with invalid password' do
    it '' do
      put :create, sessions: { username: 'god', password: 'Wrong password'}
      expect(response).to have_http_status(:success)
      expect(current_user).to be_nil
      expect(flash[:alert]).not.to be_nil
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #create with valid username and password' do
    it 'signs in user and redirects to root' do
      put :create, sessions: { username: 'god', password: 'My name is God almighty.' }
      #expect(current_user).not.to be_nil
      expect(response).to redirect_to(:root)
      expect(response).to redirect_to(:root)
    end
  end

  describe 'GET #destroy' do
    it 'returns http success' do
      get :destroy
      expect(current_user).to be_nil
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
