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
        scope.with_being_graded_state.joins(:course_tutors).where('course_tutors.user_id = ?', user.id)
      end
    end
  end

  def show?
    user
  end

  # def can_grade?
  #   record.being_graded? and CourseTutor.exists?(user: user, course: record)
  # end

  # def can_view_grades?
  #   user.admin? or CourseTutor.exists?(user: user, course: record)
  # end

end
