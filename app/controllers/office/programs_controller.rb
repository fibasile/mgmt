class Office::ProgramsController < Office::OfficeController

  def index
    @programs = Program.all
  end

  def show
    @program = Program.find(params[:id])
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.create(program_params)
    respond_with @program, location: -> { [:office,@program] }
  end

  def edit
    @program = Program.find(params[:id])
  end

  def update
    @program = Program.find(params[:id])
    @program.update_attributes(program_params)
    respond_with @program, location: -> { [:office,@program] }
  end

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    respond_with @program, location: -> { office_programs_path }
  end

private

  def program_params
    params.require(:program).permit!
  end

end
