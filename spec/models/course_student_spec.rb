require 'rails_helper'

RSpec.describe CourseStudent, :type => :model do
  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_presence_of :user }

  it "has unique user/course" do
    course_student = create(:course_student)
    expect {
      create(:course_student, course: course_student.course, user: course_student.user)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

end
