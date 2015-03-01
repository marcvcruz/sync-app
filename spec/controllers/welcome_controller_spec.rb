require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe 'GET #index for unauthenticated user' do

    it 'redirects to sign-in page' do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

end
