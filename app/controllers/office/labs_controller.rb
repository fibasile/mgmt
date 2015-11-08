class Office::LabsController < Office::OfficeController

  def index
    @labs = policy_scope(Lab)
      .order('labs.name')
      .includes(:programs)
  end

  def show
    @lab = Lab.find(params[:id])
    authorize @lab
  end

  def new
    @lab = Lab.new
    authorize @lab
  end

  def create
    @lab = Lab.create(lab_params)
    authorize @lab
    respond_with @lab, location: -> { [:office,@lab] }
  end

  def edit
    @lab = Lab.find(params[:id])
    authorize @lab
  end

  def update
    @lab = Lab.find(params[:id])
    authorize @lab
    @lab.update_attributes(lab_params)
    respond_with @lab, location: -> { [:office,@lab] }
  end

  def destroy
    @lab = Lab.find(params[:id])
    authorize @lab
    @lab.destroy
    respond_with @lab, location: -> { office_labs_path }
  end



private

  def lab_params
    params.require(:lab).permit!
  end


end
