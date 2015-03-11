class Office::CourseStudentsController < Office::OfficeController

  before_action :load_course

  def new
    @course_student = @course.course_students.build
    @users = User.order(:first_name) - @course.students
    authorize @course_student
    # @users = User.order(:first_name)
    #   .joins("LEFT OUTER JOIN course_students ON course_students.user_id = users.id")
    #   .where("course_students.course_id IS NULL OR course_students.course_id != #{@course.id}")
  end

  def edit
    @course_student = @course.course_students.find(params[:id])
    authorize @course_student
    @users = [@course_student.user]
  end

  def update
    @course_student = @course.course_students.find(params[:id])
    authorize @course_student
    @course_student.update_attributes(course_student_params)
    respond_with @course_student, location: -> { [:office,@course] }
  end

  def create
    @course_student = @course.course_students.create(course_student_params)
    authorize @course_student
    respond_with @course_student, location: -> { [:office,@course] }
  end

  def destroy
    @course_student = @course.course_students.find(params[:id])
    authorize @course_student
    @course_student.destroy
    respond_with @course_student, location: -> { [:office,@course] }
  end

private

  def course_student_params
    params.require(:course_student).permit!
  end

  def load_course
    @course = Course.find(params[:course_id])
  end

end
