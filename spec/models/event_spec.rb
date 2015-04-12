require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) {
    FactoryGirl.create :event
  }

  it 'validates with valid attribute values' do
    expect(event.valid?).to be true
  end

  it 'requires an organizer' do
    event.organizer = nil
    expect(event.valid?).to be false
    expect(event.errors.messages[:organizer].empty?).to be false
  end

  it 'requires a description' do
    event.description = ''
    expect(event.valid?).to be false
    expect(event.errors.messages[:description].empty?).to be false
  end

  it 'requires a start date' do
    event.start_date = nil
    expect(event.valid?).to be false
    expect(event.errors.messages[:start_date].empty?).to be false
  end

  context 'all day event' do
    before :each do
      event.is_all_day = true
    end

    it 'does not require a start time' do
      event.start_time = nil
      expect(event.valid?).to be true
    end
  end

  context 'not an all day event' do
    before :each do
      event.is_all_day = false
    end

    it 'requires a start time' do
      event.start_time = nil
      expect(event.valid?).to be false
      expect(event.errors.messages[:start_time].empty?).to be false
      event.start_time = Faker::Time.forward 2
      expect(event.valid?).to be true
    end
  end
end
