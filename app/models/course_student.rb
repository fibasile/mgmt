class CourseStudent < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :lab

  counter_culture :course, column_name: 'students_counter_cache'

  validates_presence_of :user, :course, :lab
  validates_uniqueness_of :user_id, scope: :course_id

end
