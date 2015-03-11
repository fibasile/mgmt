class UserPolicy < AdminPolicy

  def create?
    user.admin?
  end

end
