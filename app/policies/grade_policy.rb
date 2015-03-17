class GradePolicy < AdminPolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.all#joins(:course_tutors).where('course_tutors.user_id = ?', current_user.id)
      end
    end
  end

  def create?
    if tutor = CourseTutor.find_by(course: record.course, user: user)
      # tutor.grades_submitted_at.blank?
      true
    else
      user.admin?
    end
  end

  def update?

    if record.new_record?
      create?
    else
      user == record.grader
    end
  end

end
