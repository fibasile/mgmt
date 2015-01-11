FactoryGirl.define do
  factory :grade do
    association :course
    association :grader, factory: :user
    association :gradee, factory: :user
    value 60
    public_notes "ok, try harder next time"
    private_notes "lacking some important details"
    approved_at { 1.hour.ago }
    viewed_at { 5.minutes.ago }
  end

end
