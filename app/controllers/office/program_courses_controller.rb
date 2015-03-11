class Office::ProgramCoursesController < Office::OfficeController

  before_action :load_program

  def new
    @program_course = @program.program_courses.build
    authorize @program_course
    @courses = Course.order(:name) - @program.courses
  end

  def edit
    @program_course = @program.program_courses.find(params[:id])
    authorize @program_course
  end

  def update
    @program_course = @program.program_courses.find(params[:id])
    authorize @program_course
    @program_course.update_attributes(program_course_params)
    respond_with @program_course, location: -> { [:office,@program] }
  end

  def create
    @program_course = @program.program_courses.create(program_course_params)
    authorize @program_course
    respond_with @program_course, location: -> { [:office,@program] }
  end

  def destroy
    @program_course = @program.program_courses.find(params[:id])
    authorize @program_course
    @program_course.destroy
    respond_with @program_course, location: -> { [:office,@program] }
  end

private

  def program_course_params
    params.require(:program_course).permit!
  end

  def load_program
    @program = Program.find(params[:program_id])
  end

end
