require 'faker'

FactoryGirl.define do
  factory :event do
    description       { Faker::Lorem.sentence }
    starting_at       { Faker::Date.forward 10 }
    is_all_day        false
    notes             { Faker::Lorem.sentences 2 }
    association :organizer, factory: :user
  end

  factory :all_day_event, class: Event do
    description         { Faker::Lorem.sentence }
    starting_at         { Faker::Date.forward 10 }
    is_all_day          true
    notes               { Faker::Lorem.sentences 2 }
    association :organizer, factory: :user
  end
end
