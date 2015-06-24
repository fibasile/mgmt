class StudentsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  http_basic_authenticate_with name: "office", password: "fablab+house", except: :report_card

  def report_card
    if current_user.courses_taught.any?
      redirect_to office_root_url
    else
      @user = current_user
      courses = @user.received_grades.includes(course: :tutors).where('grades.value > 0').order('courses.starts_on', 'courses.name', 'grades.value ASC')
      # .where('courses.starts_on < ?', Date.parse('1 Feb 2015'))
      @warning = courses..map{|g| g.value }.reject(&:blank?).detect{|g| g < 5}
      # where('courses.starts_on = ?', Date.parse('2015/01/01'))
      @courses_with_months = courses.group_by{|g| g.course.starts_on}
    end
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
