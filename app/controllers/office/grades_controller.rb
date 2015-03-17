class Office::GradesController < Office::OfficeController

  before_action :load_course, except: :create
  skip_after_action :verify_policy_scoped
  respond_to :html, :js, :json

  def index
    @students = User.joins(:course_students)
      .where('course_students.course_id = ?', @course.id)
      .order('first_name')

    # grades.grader_id IS NOT NULL AND (
    @grades = Grade.where('grades.course_id = ?', @course.id)
      .where('grades.value IS NOT NULL OR grades.public_notes IS NOT NULL')
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
    course = Course.find(params[:id])
    gradee = User.find(params[:gradee_id])
    old_grade = Grade.find_or_initialize_by(course: course, gradee: gradee, grader: current_user)
    @grade = Grade.new(old_grade.dup.attributes.merge(grade_params))

    # Grade.create( grade_params.merge(old_grade.attributes.select{|g| grade_params.keys.include? g }) )
    # current_user.given_grades
    authorize @grade

    # Rails.logger.info respond_with_bip(@grade)
    # respond_with @grade, location: -> { office_course_grades_path(@course) }
    respond_to do |format|
      if @grade.save
        # format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { return respond_with_bip(@grade) }
      else
        # format.html { render :action => "edit" }
        format.json { return respond_with_bip(@grade) }
      end
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
