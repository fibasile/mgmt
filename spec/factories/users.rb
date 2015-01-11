FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    first_name 'Peter'
    last_name 'Griffin'
  end

end