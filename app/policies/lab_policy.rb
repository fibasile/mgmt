class LabPolicy < AdminPolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
    #   else
        # scope.joins(courses: :course_tutors).where('course_tutors.user_id = ?', user.id)
      end
    end
  end

  def show?
    user
  end

  def create?
    user.admin?
  end

end
