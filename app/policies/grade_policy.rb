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
    user.admin? or user.course_tutors.where(course: record.course).exists?
  end

  def update?
    create?
  end

end
