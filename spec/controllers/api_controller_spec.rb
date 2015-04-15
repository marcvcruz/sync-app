require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe "GET #username_uniqueness" do
    it "returns http success" do
      get :username_uniqueness
      expect(response).to have_http_status(:success)
    end
  end

end
