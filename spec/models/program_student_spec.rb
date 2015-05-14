require 'rails_helper'

RSpec.describe ProgramStudent, type: :model do
  it "has to_s" do
    ps = create(:program_student)
    expect(ps.to_s).to eq(ps.user.name)
  end
end
