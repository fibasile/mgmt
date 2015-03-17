class CoursePolicy < AdminPolicy

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
        scope.joins(:course_tutors).where('course_tutors.user_id = ?', user.id)
      end
    end
  end

  # def show?
  #   user.admin? || can_grade?
  # end

  def can_grade?
    record.being_graded? and CourseTutor.exists?(user: user, course: record)
  end

  def can_view_grades?
    user.admin? or CourseTutor.exists?(user: user, course: record)
  end

end
