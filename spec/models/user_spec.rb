require 'rails_helper'

RSpec.describe User, :type => :model do

  it { is_expected.to have_many :given_grades }
  it { is_expected.to have_many :received_grades }

  it { is_expected.to have_many :courses_studied }
  it { is_expected.to have_many :courses_taught }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }

  let(:user) { create(:user) }

  it "has courses_with_grades" do
    a = create(:course)
    b = create(:course)

    user.courses_studied << a
    grade = create(:grade, value: 50, public_notes: 'hello', gradee: user, course: a)

    course = user.courses_with_grades.first
    expect(user.courses_with_grades.size).to eq(1)
    expect(course.id).to eq(a.id)
    expect(course.grade).to eq(50)
    expect(course.grade_notes).to eq('hello')
  end

  it "has to_s" do
    expect( User.new(first_name: 'Homer', last_name: 'Simpson').to_s ).to eq('Homer Simpson')
  end

  it "cleans email" do
    expect(FactoryGirl.create(:user, email: ' SILLY@email.com').email).to eq('silly@email.com')
  end

end
