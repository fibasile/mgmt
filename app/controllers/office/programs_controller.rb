class Office::ProgramsController < Office::OfficeController

  def index
    @programs = policy_scope(Program).uniq
  end

  def show
    @program = Program.includes(program_students: :user).order('users.first_name').find(params[:id])
    authorize @program
  end

  def new
    @program = Program.new
    authorize @program
  end

  def create
    @program = Program.create(program_params)
    authorize @program
    respond_with @program, location: -> { [:office,@program] }
  end

  def edit
    @program = Program.find(params[:id])
    authorize @program
  end

  def update
    @program = Program.find(params[:id])
    authorize @program
    @program.update_attributes(program_params)
    respond_with @program, location: -> { [:office,@program] }
  end

  def destroy
    @program = Program.find(params[:id])
    authorize @program
    @program.destroy
    respond_with @program, location: -> { office_programs_path }
  end

private

  def program_params
    params.require(:program).permit!
  end

end
