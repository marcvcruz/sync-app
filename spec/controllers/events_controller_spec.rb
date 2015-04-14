require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before :each do
    controller.instance_variable_set :@current_user, user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status :success
      expect(assigns(:event).new_record?).to be true
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    xit 'returns http success' do

    end
  end

  describe 'GET #edit' do
    xit 'returns http success' do
      # get :edit
      # expect(response).to have_http_status(:success)
      # expect(response).to render_template :edit
      # expect(assigns(:event))
    end
  end

  describe 'PUT #update' do
    xit 'returns http success' do
      # get :update
      # expect(response).to have_http_status(:success)
      # expect(response).to redirect_to :root
    end
  end

end
