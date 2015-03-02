class StudentsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  http_basic_authenticate_with name: "office", password: "fablab+house", except: :report_card

  def report_card
    @courses = current_user.courses_with_grades
    @warning = @courses.detect{|c| (c.grade || 0).between?(4,4.999) }
  end

  def index
    @students = User.all.order(:first_name)
    render :index, layout: false
  end

  def show
    @student = User.find(params[:id])
    @courses = @student.courses_with_grades
    @weighted_average = (9.0 / 22.0) # transversal workshop
    @courses.each do |course|
      @weighted_average += course.grade * ((course.credits || 0.0)/22.0)
    end

    render pdf: "#{@student.name}",
      template: 'students/show.html.erb',
      disposition: 'inline',
      show_as_html: params[:debug].present?,
      page_size: 'A4',
      disable_javascript: true,
      grayscale: false,
      header: {
        html: {
          template: 'students/_pdf_header.html.erb'
        }
      },
      footer: {
        html: {
          template: 'students/_pdf_footer.html.erb'
        }
      }

  end

end
