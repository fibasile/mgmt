class StudentsController < ApplicationController
  
  before_action :authenticate_user!

  def report_card
    @courses = current_user.courses_with_grades
    @warning = @courses.detect{|c| (c.grade || 0).between?(4,4.999) }
  end  
end
