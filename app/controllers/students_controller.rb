class StudentsController < ApplicationController
  
  before_action :authenticate_user!, except: [:all_report_cards]
  http_basic_authenticate_with name: "iaac", password: "checking things...", only: :all_report_cards

  def all_report_cards
  end

  def report_card
    @courses = current_user.courses_with_grades
    @warning = @courses.detect{|c| (c.grade || 0).between?(4,4.999) }
  end
  
end
