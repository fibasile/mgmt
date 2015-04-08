class TutorMailer < ApplicationMailer

  def invitation user_id
    @user = User.find(user_id)
    mail to: "#{@user.name} <#{@user.email}>", subject: "[IAAC] Grades"
  end

  def low_grades tutor_id, grade_ids
    @tutor = User.find(tutor_id)
    @grades = Grade.find(grade_ids)
    mail to: "#{@tutor.name} <#{@tutor.email}>", subject: "[IAAC] Incomplete Grades"
  end

end
