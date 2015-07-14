require 'rails_helper'

RSpec.describe EventSerializer do
  let(:event) { FactoryGirl.create :event }

  it 'can serialize events' do
    json = JSON.parse EventSerializer.new(event).to_json(root: false)
    expect(json).to eql(
                        {
                            id: event.id,
                            description: event.description,
                            isAllDay: event.is_all_day,
                            startingOn: event.starting_on ,
                            startingAt: event.starting_at,
                            notes: event.notes
                        }.as_json)
  end
end