class AddCanGradeToCourseTutors < ActiveRecord::Migration
  def change
    add_column :course_tutors, :can_grade, :boolean, default: true
  end
end
