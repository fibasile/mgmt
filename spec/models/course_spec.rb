require 'rails_helper'

RSpec.describe Course, :type => :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many :students }
  it { is_expected.to have_many :tutors }
  it { is_expected.to have_many :grades }
end
