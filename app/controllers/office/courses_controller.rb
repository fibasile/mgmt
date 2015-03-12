class Office::CoursesController < Office::OfficeController

  def index
    @courses = policy_scope(Course).order(:name).includes(:programs, :tutors).order('users.first_name')
  end

  def show
    @course = Course.includes(:programs, course_students: :user, course_tutors: :user).order('users.first_name').find(params[:id])
    @tutors = @course.course_tutors
    @students = @course.course_students
    authorize @course
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.create(course_params)
    authorize @course
    respond_with @course, location: -> { [:office,@course] }
  end

  def edit
    @course = Course.find(params[:id])
    authorize @course
  end

  def update
    @course = Course.find(params[:id])
    authorize @course
    @course.update_attributes(course_params)
    respond_with @course, location: -> { [:office,@course] }
  end

  def destroy
    @course = Course.find(params[:id])
    authorize @course
    @course.destroy
    respond_with @course, location: -> { office_courses_path }
  end

private

  def course_params
    params.require(:course).permit!
  end

end
