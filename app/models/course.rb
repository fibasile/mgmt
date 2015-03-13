class Course < ActiveRecord::Base

  has_ancestry

  include Workflow
  workflow do
    state :draft do
    end
    state :published
    state :being_graded
    state :graded
    state :archived
  end

  SEMINARS = {
    "DAT" => "Data Informed Structures",
    "ENC" => "Encrypted Rome",
    "ENV" => "Environmental Analysis",
    "KNO" => "Knowledge City",
    "PHY" => "Physical Computing",
    "ROB" => "Robotic Workshop",
    "N/A" => "-"
  }

  STUDIOS = {
    "RS1" => "RS I - Intelligent Cities",
    "RS2" => "RS II - Self-Sufficient Buildings",
    "RS3" => "RS III - Digital Matter",
    "RS4" => "RS IV - Advanced Interaction",
    "RS5" => "RS V - Design with Nature",
    "N/A" => "-"
  }

  validates :name, presence: true, uniqueness: true

  has_many :course_tutors, dependent: :destroy
  has_many :course_students, dependent: :destroy

  has_many :program_courses
  has_many :programs, through: :program_courses

  has_many :tutors, class_name: "User", through: :course_tutors, source: :user
  has_many :students, class_name: "User", through: :course_students, source: :user

  has_many :grades

  attr_accessor :copy_students_from_course_id
  before_create :copy_students

  def grading_status
    a = []
    if grades_remaining == (s = students.count)
      if s > 0
        a << "Complete"
      else
        a << "No Students"
      end
    else
      # "#{grades_remaining} need finishing"
      a << "Incomplete"
    end
    a << "#{grades_remaining}/#{students.count}"
    return a
  end

  def to_s
    name
  end

  def grades_remaining
    # students.count -
    (Grade.where('course_id = ? AND value > 0 AND value <= 10 AND value IS NOT NULL', id).pluck(:gradee_id).uniq.count)
  end

private

  def copy_students
    if copy_students_from_course_id.present?
      students << Course.find(copy_students_from_course_id).students
    end
  end

end
