require 'rails_helper'

RSpec.describe User, :type => :model do

  it { is_expected.to have_many :given_grades }
  it { is_expected.to have_many :received_grades }

  it { is_expected.to have_many :courses_studied }
  it { is_expected.to have_many :courses_taught }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }

  let(:user) { create(:user) }

  it "has country" do
    expect(build_stubbed(:user, country_code: 'FR').country).to eq("France")
    expect(build_stubbed(:user, country_code: nil).country).to be_blank
  end

  def invite
    sign_in_count = 0
    last_sign_in_at = nil
    generate_token(:invitation_code)
    save(validate: false)
    StudentMailer.invitation(id).deliver_now
  end


  it "has invite" do
    user = create(:user, sign_in_count: 3, last_sign_in_at: Time.now)
    user.invite
    user.reload
    expect(user.sign_in_count).to eq(0)
    expect(user.last_sign_in_at).to be_nil
    expect(user.invitation_code).to be_present
    expect(last_email.to).to eq([user.email])
    expect(last_email.subject).to match("Your Grades")
  end

  it "requires iaac.net email" do
    # expect(build_stubbed(:user, email: 'notiaac@bitsushi.com').valid?).to be_falsey
    # expect(build_stubbed(:user, email: ' invalid@iaac.com ').valid?).to be_falsey
    expect(build_stubbed(:user, email: 'john@@iaac.net').valid?).to be_falsey
    # expect(build_stubbed(:user, email: 'john@iaac.net.').valid?).to be_falsey
    expect(build_stubbed(:user, email: 'john@iaac.net').valid?).to be_truthy
  end

  it "has courses_with_grades" do
    a = create(:course)
    b = create(:course)

    user.courses_studied << a
    grade = create(:grade, value: 5, public_notes: 'hello', gradee: user, course: a, created_at: 1.year.ago)

    create(:grade, value: 4, public_notes: 'hello', gradee: user, course: b)

    course = user.courses_with_grades.first
    expect(user.courses_with_grades.size).to eq(1)
    expect(course.id).to eq(a.id)
    expect(course.grade.to_f).to eq(5.0)
    expect(course.grade_notes).to eq('hello')
  end

  it "has to_s" do
    expect( User.new(first_name: 'Homer', last_name: 'Simpson').to_s ).to eq('Homer Simpson')
  end

  it "cleans email" do
    expect(FactoryGirl.create(:user, email: ' SILLY@IAAC.net').email).to eq('silly@iaac.net')
  end


  describe "#send_password_reset" do

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      expect(user.password_reset_token).not_to eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      expect(user.reload.password_reset_sent_at).to be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      expect(last_email.to).to include(user.email)
    end

  end

end
