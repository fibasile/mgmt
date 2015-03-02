class Course < ActiveRecord::Base

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

  has_many :course_tutors
  has_many :course_students

  has_many :tutors, class_name: "User", through: :course_tutors, source: :user
  has_many :students, class_name: "User", through: :course_students, source: :user

  has_many :grades

  def to_s
    name
  end

end
