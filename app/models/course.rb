class Course < ActiveRecord::Base
  
  validates_presence_of :name

  has_many :course_tutors
  has_many :course_students

  has_many :tutors, class_name: "User", through: :course_tutors, source: :user
  has_many :students, class_name: "User", through: :course_students, source: :user

  has_many :grades

  def to_s
    name
  end
end
