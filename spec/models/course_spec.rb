require 'rails_helper'

RSpec.describe Course, :type => :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many :students }
  it { is_expected.to have_many :tutors }
  it { is_expected.to have_many :grades }
  it { is_expected.to validate_uniqueness_of :name }

  it "has SEMINARS" do
    expect(Course::SEMINARS["N/A"]).to eq("-")
    expect(Course::SEMINARS["ROB"]).to eq("Robotic Workshop")
  end

  it "has STUDIOS" do
    expect(Course::STUDIOS["N/A"]).to eq("-")
    expect(Course::STUDIOS["RS3"]).to eq("RS III - Digital Matter")
  end

  it "has to_s" do
    expect(build_stubbed(:course, name: "New name").to_s).to eq("New name")
  end

end
