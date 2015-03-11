class Office::CourseTutorsController < Office::OfficeController

  before_action :load_course

  def new
    @course_tutor = @course.course_tutors.build
    authorize @course_tutor

    @users = User.order(:first_name) - @course.tutors

    # @users = User.order(:first_name)
    #   .joins("LEFT OUTER JOIN course_tutors ON course_tutors.user_id = users.id")
    #   .where("course_tutors.course_id IS NULL OR course_tutors.course_id != #{@course.id}")
  end

  def edit
    @course_tutor = @course.course_tutors.find(params[:id])
    authorize @course_tutor
    @users = [@course_tutor.user]
  end

  def update
    @course_tutor = @course.course_tutors.find(params[:id])
    authorize @course_tutor
    @course_tutor.update_attributes(course_tutor_params)
    respond_with @course_tutor, location: -> { [:office,@course] }
  end

  def create
    @course_tutor = @course.course_tutors.create(course_tutor_params)
    authorize @course_tutor
    respond_with @course_tutor, location: -> { [:office,@course] }
  end

  def destroy
    @course_tutor = @course.course_tutors.find(params[:id])
    authorize @course_tutor
    @course_tutor.destroy
    respond_with @course_tutor, location: -> { [:office,@course] }
  end

private

  def course_tutor_params
    params.require(:course_tutor).permit!
  end

  def load_course
    @course = Course.find(params[:course_id])
  end

end
