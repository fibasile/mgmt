class AddGradesSubmittedAtToCourseTutor < ActiveRecord::Migration
  def change
    add_column :course_tutors, :grades_submitted_at, :datetime
  end
end
