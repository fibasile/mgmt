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
    if grades_counter_cache == students_counter_cache
      if students_counter_cache > 0
        a << "Complete"
      else
        a << "No Students"
      end
    else
      # "#{grades_remaining} need finishing"
      a << "Incomplete"
    end
    a << "#{grades_counter_cache}/#{students_counter_cache}"
    return a
  end

  def full_name
    [name, subtitle].reject(&:blank?).join(' - ')
  end

  def to_s
    name
  end

  def grades_remaining
    grades_counter_cache
    # students.count -
    # (Grade.where('course_id = ? AND value > 0 AND value <= 10 AND value IS NOT NULL', id).pluck(:gradee_id).uniq.count)
  end

  def all_grades
    grades.includes(:gradee).order('users.first_name ASC, users.last_name ASC, grades.value DESC').includes(:grader)
  end

  def grades_to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["ID", "First Name", "Last Name", "Final Grade", "Grader", "Group", "Comments"]
      all_grades.each do |grade|
        if grade.gradee
          csv << [grade.gradee.id, grade.gradee.first_name, grade.gradee.last_name, grade.value, grade.grader, grade.group, grade.public_notes]
        end
      end
    end
  end

private

  def copy_students
    if copy_students_from_course_id.present?
      students << Course.find(copy_students_from_course_id).students
    end
  end

end
