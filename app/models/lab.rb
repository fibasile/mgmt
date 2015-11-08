class Lab < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :lab_programs
  has_many :programs, through: :lab_programs

#   has_many lab_tutors
#   has_many :tutors, class_name: "User", through: :lab_tutors, source: :user

#   has_many lab_students
#   has_many :students, class_name: "User", through: :lab_students, source: :user

  def to_s
    name
  end

end
