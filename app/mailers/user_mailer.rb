class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail to: "#{@user.name} <#{@user.email}>", subject: "[IAAC] Password Reset", cc: nil
  end
end
