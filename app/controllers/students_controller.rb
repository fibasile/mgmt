class StudentsController < ApplicationController
  
  before_action :authenticate_user!
  http_basic_authenticate_with name: "john", password: "test", except: :report_card

  def report_card
    @courses = current_user.courses_with_grades
    @warning = @courses.detect{|c| (c.grade || 0).between?(4,4.999) }
  end

  def index
    @students = User.all.order(:first_name)
  end

  def show
    @student = User.find(params[:id])
    render pdf: "#{@student.name}",
      template: 'students/show.html.erb',
      disposition: 'attachment'
  end

end
