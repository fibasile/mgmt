require 'rails_helper'

RSpec.describe Grade, :type => :model do
  it { is_expected.to belong_to :course }
  it { is_expected.to belong_to :grader }
  it { is_expected.to belong_to :gradee }

  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_presence_of :gradee }
  skip { is_expected.to validate_uniqueness_of(:gradee_id).scoped_to(:course_id) }


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

  it "has self.formatted_value" do
    expect(Grade.formatted_value(9.5244)).to eq("9.52")
    expect(Grade.formatted_value(8)).to eq("8.00")
    expect(Grade.formatted_value(nil)).to eq("-")
  end

end
