class Office::CourseTutorsController < Office::OfficeController
  def new
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(params[:course_id])
    @course_tutor = @course.course_tutors.create(course_tutor_params)
    respond_with @course_tutor, location: -> { [:office,@course] }
  end

private

  def course_tutor_params
    params.require(:course_tutor).permit!
  end

end
