class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
    authorize @courses
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students.order('first_name')
  end

end
