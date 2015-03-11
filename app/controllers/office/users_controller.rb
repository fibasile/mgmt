class Office::UsersController < Office::OfficeController
  def index
    @users = policy_scope(User).includes(:programs).order(:first_name)
  end

  def show
    @user = User.includes(:received_grades).find(params[:id])
    @grades = @user.received_grades
    authorize @user
  end
end
