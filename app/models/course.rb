class Course < ActiveRecord::Base

  has_ancestry

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

  def grading_status
    if grades_remaining == students.count
      "Complete"
    else
      # "#{grades_remaining} need finishing"
      "Incomplete - #{grades_remaining}/#{students.count}"
    end
  end

  def to_s
    name
  end

  def grades_remaining
    # students.count -
    (Grade.where('course_id = ? AND value > 0 AND value <= 10 AND value IS NOT NULL', id).pluck(:gradee_id).uniq.count)
  end

end
