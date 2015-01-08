FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "MAA00#{n}" }
    subtitle "A test subtitle"
    description "This is a great course blah blah blah"
    credits 20
    published true
  end

end
