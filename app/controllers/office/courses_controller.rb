class Office::CoursesController < Office::OfficeController

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
    respond_with @course, location: -> { [:office,@course] }
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update_attributes(course_params)
    respond_with @course, location: -> { [:office,@course] }
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_with @course, location: -> { office_courses_path }
  end

private

  def course_params
    params.require(:course).permit!
  end

end
