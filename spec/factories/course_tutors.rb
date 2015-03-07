FactoryGirl.define do
  factory :course_tutor do
    association :user
    association :course
    role "Assistant"
    role_description "To help"
  end

end
