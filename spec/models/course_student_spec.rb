require 'rails_helper'

RSpec.describe CourseStudent, :type => :model do
  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_presence_of :user }
  skip { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:course_id) }
end
