class Office::UsersController < Office::OfficeController

  def index
    @users = policy_scope(User).includes(:programs).order(:first_name)
  end

  def show
    @user = User.includes(:received_grades).find(params[:id])
    @grades = @user.received_grades
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.create(user_params)
    authorize @user
    respond_with @user, location: -> { [:office,@user] }
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    @user.update_attributes(user_params)
    respond_with @user, location: -> { office_users_url }
  end

private

  def user_params
    params.require(:user).permit!
  end

end
