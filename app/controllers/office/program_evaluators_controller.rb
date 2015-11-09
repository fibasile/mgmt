class Office::ProgramEvaluatorsController < Office::OfficeController

  before_action :load_program

  def new
    @program_evaluator = @program.program_evaluators.build
    authorize @program_evaluator
  end

  def edit
    @program_evaluator = @program.program_evaluators.find(params[:id])
    authorize @program_evaluator
  end

  def update
    @program_evaluator = @program.program_evaluators.find(params[:id])
    @program_evaluator.update_attributes(program_evaluator_params)
    authorize @program_evaluator
    respond_with @program_evaluator, location: -> { [:office,@program] }
  end

  def create
    @program_evaluator = @program.program_evaluators.create(program_evaluator_params)
    authorize @program_evaluator
    respond_with @program_evaluator, location: -> { [:office,@program] }
  end

  def destroy
    @program_evaluator = @program.program_evaluators.find(params[:id])
    authorize @program_evaluator
    @program_evaluator.destroy
    respond_with @program_evaluator, location: -> { [:office,@program] }
  end

private

  def program_evaluator_params
    params.require(:program_evaluator).permit!
  end

  def load_program
    @program = Program.find(params[:program_id])
  end

end
