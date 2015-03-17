class TutorMailer < ApplicationMailer

  def invitation user_id
    @user = User.find(user_id)
    mail to: "#{@user.name} <#{@user.email}>", subject: "Grading your students"
  end
end
