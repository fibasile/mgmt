require "rails_helper"

RSpec.describe StudentMailer, :type => :mailer do

  describe "invitation" do
    let(:user) { create(:user, first_name: "Bart") }
    let(:mail) { StudentMailer.invitation(user.id) }

    it "send user password reset url" do
      user.update_attribute(:invitation_code, "anything")
      expect(mail.subject).to eq("Your Grades")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["notifications@mgmt.iaac.net"])
      expect(mail.body.encoded).to match( "Bart," )
      expect(mail.body.encoded).to match( invite_path(invitation_code: "anything") )
    end
  end

end
