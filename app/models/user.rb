class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :given_grades, foreign_key: :grader_id, class_name: "Grade"
  has_many :received_grades, foreign_key: :gradee_id, class_name: "Grade"

  has_many :course_students
  has_many :course_tutors
  has_many :courses_studied, class_name: "Course", through: :course_students, source: :course
  has_many :courses_taught, class_name: "Course", through: :course_tutors, source: :course

  validates_presence_of :first_name, :last_name

  def courses_with_grades
    courses_studied
      .joins('LEFT OUTER JOIN grades ON grades.course_id = courses.id')
      .select('courses.*, grades.value as grade, grades.public_notes as grade_notes')
      .where('grades.gradee_id': [id, nil])
      .order('name')
  end

  def to_s
    email
  end

end
