class Office::LabProgramsController <  Office::OfficeController

  before_action :load_lab

  def new
    @lab_program = @lab.lab_programs.build
    authorize @lab_program
    @programs = Program.order(:name) - @lab.programs
  end
  
  def create
    @lab_program = @lab.lab_programs.create(lab_program_params)
    authorize @lab_program
    respond_with @lab_program, location: -> { [:office,@lab] }
  end
  
  def edit
    @lab_program = @lab.lab_programs.find(params[:id])
    authorize @lab_program
  end

  def update
    @lab_program = @lab.lab_programs.find(params[:id])
    authorize @lab_program
    @lab_program.update_attributes(lab_program_params)
    respond_with @lab_program, location: -> { [:office,@lab] }
  end

  def destroy
    @lab_program = @lab.lab_programs.find(params[:id])
    authorize @lab_program
    @lab_program.destroy
    respond_with @lab_program, location: -> { [:office,@lab] }
  end
  
private

  def load_lab
    @lab = Lab.find(params[:lab_id])
  end
  
  def lab_program_params
    params.require(:lab_program).permit! 
  end
end
