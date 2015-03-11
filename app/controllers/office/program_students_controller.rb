class Office::ProgramStudentsController < Office::OfficeController

  before_action :load_program

  def new
    @program_student = @program.program_students.build
    authorize @program_student
  end

  def edit
    @program_student = @program.program_students.find(params[:id])
    authorize @program_student
  end

  def update
    @program_student = @program.program_students.find(params[:id])
    @program_student.update_attributes(program_student_params)
    authorize @program_student
    respond_with @program_student, location: -> { [:office,@program] }
  end

  def create
    @program_student = @program.program_students.create(program_student_params)
    authorize @program_student
    respond_with @program_student, location: -> { [:office,@program] }
  end

  def destroy
    @program_student = @program.program_students.find(params[:id])
    authorize @program_student
    @program_student.destroy
    respond_with @program_student, location: -> { [:office,@program] }
  end

private

  def program_student_params
    params.require(:program_student).permit!
  end

  def load_program
    @program = Program.find(params[:program_id])
  end

end
