require 'rails_helper'

RSpec.describe CourseTutor, :type => :model do
  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_presence_of :user }

  it "has unique user/course" do
    course_tutor = create(:course_tutor)
    expect {
      create(:course_tutor, course: course_tutor.course, user: course_tutor.user)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

end
