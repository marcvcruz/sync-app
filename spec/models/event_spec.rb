require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) {
    FactoryGirl.create :event, starting_date_time: Time.parse('2015-05-04 04:30 PM')
  }

  it 'requires an organizer' do
    expect { event.organizer = nil }.to change(event, :valid?).from(true).to(false)
  end

  it 'requires a description' do
    expect { event.description = '' }.to change(event, :valid?).from(true).to(false)
  end

  it 'requires description to be less than 100 characters' do
    expect { event.description = 'This description is over 100 characters in total length and therefore should fail the length validation' }
      .to change(event, :valid?).from(true).to(false)
  end

  describe 'start date and time validation' do
    before :each do
      event.starting_date_time = nil
    end

    it 'requires a start date' do
      expect { event.starting_on = nil }.to change(event, :valid?).from(true).to(false)
    end

    it 'requires a start time' do
      expect { event.starting_at = nil }.to change(event, :valid?).from(true).to(false)
    end
  end

  it 'can display just the date in date_input_field format' do
    expect(event.starting_on).to match /05\/04\/2015/
  end

  it 'can display just the time in time_input_field_format' do
    expect(event.starting_at).to match /4:30 PM/i
  end

  context 'that lasts all day' do
    describe 'when changed to not last all day' do
      it 'then the start time to beginning of the day' do
        expect { event.is_all_day = true }.to change(event, :starting_at).to('12:00 AM')
      end
    end
  end

  it 'can find events occurring on a given month' do
    FactoryGirl.create :event, description: 'An event two days ago', starting_date_time: 2.days.ago
    FactoryGirl.create :event, description: 'An event next month', starting_date_time: 1.month.from_now
    FactoryGirl.create :event, description: 'Latest event this month', starting_date_time: Time.now.end_of_month.end_of_day
    FactoryGirl.create :event, description: 'Earliest event this month', starting_date_time: Time.now.beginning_of_month.beginning_of_day

    events = Event.occurs_in Time.now
    expect(events.size).to eql(3)
  end
end
