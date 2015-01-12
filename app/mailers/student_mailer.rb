class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.invitation.subject
  #
  def invitation user_id
    @user = User.find(user_id)
    mail to: @user.email, subject: "Your Grades"
  end
end
