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
    it 'returns http success' do

    end
  end

  describe 'GET #edit' do
    let(:event) { FactoryGirl.create :event }

    it 'is successful' do
      get :edit, id: event.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template :edit
      expect(assigns(:event)).to eql event
    end
  end

  describe 'PUT #update' do
    let(:event) { FactoryGirl.create :event }

    it 'returns http success' do
      put :update, id: event.id, event: { is_all_day: true, description: 'New description', notes: 'New note'  }
      updated_event =  assigns(:event)
      expect(updated_event).to_not be_nil
      expect(updated_event.is_all_day).to eql true
      expect(updated_event.description).to eql 'New description'
      expect(updated_event.notes).to eql 'New note'
      expect(response).to have_http_status(302)
      expect(response).to redirect_to :events
    end
  end

  describe 'DELETE #destroy' do
    let(:event) { FactoryGirl.create :event }

    it 'deletes the event from the table' do
      delete :destroy, id: event.id
      expect(response).to have_http_status 302
      expect(response).to redirect_to :events
      expect(Event.exists? event.id).to be false
    end
  end
end
