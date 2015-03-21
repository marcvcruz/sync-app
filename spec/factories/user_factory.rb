FactoryGirl.define do
  sequence :first_name do |n|
    "First_#{n}"
  end

  sequence :last_name do |n|
    "Last_#{n}"
  end

  sequence :username do |n|
    "username_#{n}"
  end

  sequence :email do |n|
    "user#{n}@some_email.com"
  end

  factory :user do
  end

  factory :standard_user, class: User  do
    first_name
    last_name
    is_admin    false
    username
    email
    password    'Password1'
  end

  factory :admin_user, class: User do
    first_name
    last_name
    is_admin    true
    username
    email
    password    'Password1'
  end
end