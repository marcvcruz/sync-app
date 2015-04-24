require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) {
    FactoryGirl.create :event
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

  it 'requires a starting date' do
    expect { event.starting_at = nil }.to change(event, :valid?).from(true).to(false)
  end

  context 'all day event' do
    before :each do
      event.is_all_day = true
    end
  end

  context 'not an all day event' do
    before :each do
      event.is_all_day = false
    end
  end
end
