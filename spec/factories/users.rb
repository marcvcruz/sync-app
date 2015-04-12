require 'faker'

FactoryGirl.define do
  factory :user do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    is_admin    false
    username    { Faker::Internet.user_name }
    email       { Faker::Internet.email }
    password    { Faker::Internet.password }
  end

  factory :admin, class: User do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    is_admin    true
    username    { Faker::Internet.user_name }
    email       { Faker::Internet.email }
    password    { Faker::Internet.password }
  end
end