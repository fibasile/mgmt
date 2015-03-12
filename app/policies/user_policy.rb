class UserPolicy < AdminPolicy

  def create?
    user.admin?
  end

  def update?
    user.admin? or record == user
  end

end
