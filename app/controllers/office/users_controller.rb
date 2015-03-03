class Office::UsersController < Office::OfficeController
  def index
    @users = User.order(:first_name)
  end

  def show
    @user = User.find(params[:id])
  end
end
