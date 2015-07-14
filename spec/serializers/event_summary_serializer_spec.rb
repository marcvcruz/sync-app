require 'rails_helper'

RSpec.describe EventSummarySerializer do
  let(:event) { FactoryGirl.create :event }

  it 'can serialize events to an event summary' do
    json = JSON.parse EventSummarySerializer.new(event).to_json(root: false)
    expect(json).to eql( {id: event.id, description: event.description, isAllDay: event.is_all_day, startingOn: event.starting_on, startingAt: event.starting_at }.as_json)
  end
end