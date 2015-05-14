FactoryGirl.define do
  factory :program_student do
    association :user
    association :program
  end

end
