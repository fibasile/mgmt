FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    first_name 'Peter'
    last_name 'Griffin'

    studio 'RS1'
    oblig_seminar 'G1'
    seminar_1 'ROB'
    seminar_2 'KNO'
  end
end