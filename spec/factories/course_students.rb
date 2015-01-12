FactoryGirl.define do
  factory :course_student do
    association :user
    association :course
  end

end
