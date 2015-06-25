class Office::UsersController < Office::OfficeController

  def report
    @student = User.find(params[:id])
    authorize @student, :show?
    @courses = @student.courses_with_grades
    # @weighted_average = (9.0 / 22.0) # transversal workshop
    # @courses.each do |course|
    #   @weighted_average += course.grade * ((course.credits || 0.0)/22.0)
    # end
    # @weighted_average = 10

    render pdf: "#{@student.name}",
      template: 'office/users/reports/report.html.erb',
      disposition: 'inline',
      show_as_html: params[:debug].present?,
      page_size: 'A4',
      disable_javascript: true,
      grayscale: false,
      header: {
        html: {
          template: 'office/users/reports/_pdf_header.html.erb'
        }
      },
      footer: {
        html: {
          template: 'office/users/reports/_pdf_footer.html.erb'
        }
      }
  end

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
