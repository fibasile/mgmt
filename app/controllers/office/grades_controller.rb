class Office::GradesController < Office::OfficeController

  before_action :load_course
  skip_after_action :verify_policy_scoped
  respond_to :html, :js

  def index
    @students = User.joins(:course_students)
      .where('course_students.course_id = ?', @course.id)

    @grades = Grade.where('grades.course_id = ?', @course.id)
      .includes(:grader)
      .order('users.first_name')
      .order('grades.id DESC')
  end

  def show
    @grade = Grade.find(params[:id])
    authorize @grade
  end

  def new
    @grade = Grade.new
    authorize @grade
  end

  def create
    @grade = current_user.given_grades.create(grade_params)
    authorize @grade
    respond_with @grade, location: -> { office_course_grades_path(@course) }
  end

  def edit
    @grade = Grade.find(params[:id])
    authorize @grade
  end

  def update
    @grade = Grade.find(params[:id])
    authorize @grade
    @grade.update_attributes(grade_params)
    respond_with @grade, location: -> { office_course_grades_path(@course) }
  end

  def destroy
    @grade = Grade.find(params[:id])
    authorize @grade
    @grade.destroy
    respond_with @grade, location: -> { office_course_grades_path(@course) }
  end

private

  def grade_params
    params.require(:grade).permit!
  end

  def load_course
    @course = Course.find(params[:course_id])
  end

end
