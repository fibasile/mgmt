class User < ActiveRecord::Base

  has_secure_password
  validates_uniqueness_of :email

  has_many :given_grades, foreign_key: :grader_id, class_name: "Grade"
  has_many :received_grades, foreign_key: :gradee_id, class_name: "Grade"

  has_many :course_students
  has_many :course_tutors
  has_many :courses_studied, class_name: "Course", through: :course_students, source: :course
  has_many :courses_taught, class_name: "Course", through: :course_tutors, source: :course

  before_create { generate_token(:invitation_code) }

  store_accessor :temp_data,
    :studio,
    :seminar_1,
    :seminar_2,
    :oblig_seminar

  validates_presence_of :first_name, :last_name, :email
  validates :password, :password_confirmation, presence: true, length: {minimum: 6}, if: :invitation_code?

  validates_format_of :email, :with => /\A\S+@iaac\.net\z/, :message => "you must use your @iaac.net email address"

  before_save :clean_email

  def clean_email
    self.email = email.downcase.strip
  end

  def courses_with_grades
    courses_studied
      .joins('LEFT OUTER JOIN grades ON grades.course_id = courses.id')
      .select('courses.*, grades.value as grade, grades.public_notes as grade_notes')
      .where('grades.gradee_id': [id, nil])
      .order('name')
  end

  def to_s
    name
  end

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64.gsub(/[^0-9a-zA-Z]/i, '')
    end while User.exists?(column => self[column])
  end

end
