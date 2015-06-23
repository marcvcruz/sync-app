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

    context 'json format specified' do
      let(:params) {
        { format: 'json' }
      }

      context 'with no additional parameters' do
        it 'uses the current month to query for events' do
          get :index, params
          expect(controller.start_date).to eql(Date.today)
        end
      end

      context 'with year and month specified in parameters' do
        it 'uses the specified month and year to query for events' do
          params.merge! month: 4, year: 2017
          get :index, params
          expect(controller.start_date).to eql(Date.parse '2017-04-01')
        end
      end
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status :success
      expect(assigns(:event).new_record?).to be true
      expect(response).to render_template :new
    end

    context 'with a starting_date parameter' do
      let(:starting_date) {
        Date.parse('2016-10-10')
      }

      it 'sets the parameter as the new event\'s starting date' do
        get :new, starting_date: starting_date
        expect(assigns(:event).starting_date_time).to eql(starting_date.to_time)
      end
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
    let(:event) { FactoryGirl.create :event, is_all_day: false, description: 'Original description', notes: 'Original notes' }

    it 'updates the event' do
      put :update, id: event.id, event: { is_all_day: true, description: 'New description', notes: 'New note'  }
      updated_event =  Event.find(event.id)
      expect(updated_event).to_not be_nil
      expect(updated_event.is_all_day).to eql true
      expect(updated_event.description).to eql 'New description'
      expect(updated_event.notes).to eql 'New note'
      expect(response).to have_http_status(302)
      expect(response).to redirect_to monthly_calendar_path(updated_event.year, updated_event.month)
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
