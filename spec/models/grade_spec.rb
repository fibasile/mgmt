require 'rails_helper'

RSpec.describe Grade, :type => :model do
  it { is_expected.to belong_to :course }
  it { is_expected.to belong_to :grader }
  it { is_expected.to belong_to :gradee }

  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_presence_of :gradee }

  skip "has unique grade/course" do
    grade = create(:grade)
    expect {
      create(:grade, course: grade.course, gradee: grade.gradee)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "has human grades" do
    expect(Grade.new(value: nil).human_grade).to eq("NOT GRADED")
    expect(Grade.new(value: 0).human_grade).to eq("FAIL")
    expect(Grade.new(value: 0.5).human_grade).to eq("FAIL")
    expect(Grade.new(value: 4).human_grade).to eq("INCOMPLETE")
    expect(Grade.new(value: 4.99).human_grade).to eq("INCOMPLETE")
    expect(Grade.new(value: 5).human_grade).to eq("LOW PASS")
    expect(Grade.new(value: 6.85).human_grade).to eq("LOW PASS")
    expect(Grade.new(value: 7.00).human_grade).to eq("PASS")
    expect(Grade.new(value: 8.00).human_grade).to eq("PASS")
    expect(Grade.new(value: 8.9).human_grade).to eq("PASS")
    expect(Grade.new(value: 9).human_grade).to eq("HIGH PASS")
    expect(Grade.new(value: 10.00).human_grade).to eq("HIGH PASS")
  end

  it "has formatted_grade" do
    grade = build_stubbed(:grade, value: 9.2839)
    expect(grade.formatted_grade).to eq("9.28")
    expect(grade.to_s).to eq("9.28")
  end

  it "has min_4_grade" do
    grade = build_stubbed(:grade, value: 2.123)
    expect(grade.min_4_grade).to eq("4.00")
    grade = build_stubbed(:grade, value: 8.123)
    expect(grade.min_4_grade).to eq("8.12")
  end

  it "has self.formatted_value" do
    expect(Grade.formatted_value(9.5244)).to eq("9.52")
    expect(Grade.formatted_value(8)).to eq("8.00")
    expect(Grade.formatted_value(nil)).to eq("")
  end

end
