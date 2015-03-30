require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  describe '#new' do
    it 'returns http success' do
      get :new
      expect(response).to render_template :new
      expect(response).to have_http_status :success
    end
  end

  describe '#create' do
    it 'returns http success' do
      get :create
      expect(response).to have_http_status :success
    end
  end

  describe '#edit' do
    it 'returns http success' do
      user = FactoryGirl.create
      get :edit
      expect(response).to have_http_status :success
    end
  end

  describe '#patch' do
    it 'returns http success' do
      get :patch
      expect(response).to have_http_status :success
    end
  end

end
