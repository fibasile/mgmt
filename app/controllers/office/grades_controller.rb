class Office::GradesController < Office::OfficeController

  before_action :load_course, except: :create
  skip_after_action :verify_policy_scoped
  respond_to :html, :js, :json

  def index
    grade = @course.grades.build

    authorize grade, :show?

    @students = User.joins(:course_students)
      .where('course_students.course_id = ?', @course.id)
      .order('first_name')

    # grades.grader_id IS NOT NULL AND (
    # .where('grades.value IS NOT NULL OR grades.public_notes IS NOT NULL')
    @grades = Grade.where('grades.course_id = ?', @course.id)
      .includes(:grader)
      .order('users.first_name')
      .order('grades.id DESC')

    @grading = policy(grade).create?

    respond_to do |format|
      format.html
      format.csv { send_data @course.grades_to_csv }
    end
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
    course = Course.find(params[:id])
    gradee = User.find(params[:gradee_id])

    @grade = Grade.find_or_initialize_by(course: course, gradee: gradee, grader: current_user)
    # if grade_params[:value]
    #   @grade = Grade.find_or_initialize_by(course: course, gradee: gradee)
    #   # where.not(value: nil)
    # else
    #   @grade = Grade.find_or_initialize_by(course: course, gradee: gradee, grader: current_user)
    # end

    # @grade.grader = current_user
    @grade.attributes = @grade.attributes.merge(grade_params)

    authorize @grade, :update?

    respond_to do |format|
      @grade.save
      format.json { return respond_with_bip(@grade) }
    end
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
