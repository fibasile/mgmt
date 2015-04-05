class User < ActiveRecord::Base

  COURSE_TYPES = [
    'MAA01 Master in Advanced Architecture program, which is accredited by Fundació
Politécnica de Catalunya with 75 ECTS credits, and takes place from October 2014 to June 2015',
    'MAA02 Master in Advanced Architecture program, which is accredited by Fundació
Politécnica de Catalunya with 130 ECTS credits, and takes place from October 2014 to June 2016',
    'MAA01 Master in Advanced Architecture program and Open Thesis Fabrication program, which is accredited by Fundació
Politécnica de Catalunya with 75 + 25 ECTS credits, and takes place from October 2014 to January 2016']

  has_secure_password
  validates_uniqueness_of :email

  has_many :grades
  has_many :given_grades, foreign_key: :grader_id, class_name: "Grade"
  has_many :received_grades, foreign_key: :gradee_id, class_name: "Grade"

  has_many :course_students
  has_many :course_tutors
  has_many :courses_studied, class_name: "Course", through: :course_students, source: :course
  has_many :courses_taught, class_name: "Course", through: :course_tutors, source: :course

  has_many :program_students
  has_many :programs, through: :program_students#, foreign_key: :user_id

  before_create { generate_token(:invitation_code) }

  store_accessor :temp_data,
    :studio,
    :seminar_1,
    :seminar_2,
    :oblig_seminar

  validates_presence_of :first_name, :last_name, :email
  validates :password, :password_confirmation, presence: true, length: {minimum: 6}, if: :invitation_code?

  # validates_format_of :email, :with => /\A[\w\+\.]+@[\w\.]+\z/, :message => "must be your @iaac.net email address"
  validates :email, :email => true

  before_validation :clean_email

  def unique_name
    [first_name,last_name[0]].join(' ')
  end

  def photo_url
    if photo.present?
      photo.gsub('https://www.filepicker.io', 'http://iaac-cdn.johnre.es')
    else
      'https://i.imgur.com/gedfDdD.png'
    end
  end

  def course_description
    COURSE_TYPES[course_type || 0]
  end

  def clean_email
    self.email = email.downcase.strip
  end

  def age
    return if dob.blank?
    now = Time.now.utc.to_date
    now.year - dob.year - (dob.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def country
    country_code.present? ? Country[country_code].to_s : ""
  end

  def courses_with_grades
    courses_studied
      .joins('LEFT OUTER JOIN grades ON grades.course_id = courses.id')
      .select('courses.*, grades.value as grade, grades.public_notes as grade_notes')
      .where('grades.gradee_id': [id, nil])
      .where('grades.created_at < ?', Date.parse('2015/03/01') )
      .order('name')
  end

  def weighted_average cwg
    Grade.formatted_value cwg.map(&:grade).instance_eval { reduce(:+) / size.to_f }
  end

  def to_s
    name
  end

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def send_password_reset
    generate_token(:password_reset_token)
    update_attribute :password_reset_sent_at, Time.zone.now
    UserMailer.password_reset(self).deliver_now
  end

  def invite
    self.sign_in_count = 0
    self.last_sign_in_at = nil
    self.invited_at = Time.now
    generate_token(:invitation_code)
    save(validate: false)
    StudentMailer.invitation(id).deliver_now
  end

  def tutor_invite
    self.sign_in_count = 0
    self.last_sign_in_at = nil
    self.invited_at = Time.now
    generate_token(:invitation_code)
    save(validate: false)
    TutorMailer.invitation(id).deliver_now
  end

  def admin?
    clearance == 5
  end

  def grades_remaining_for course
    course.students.count - given_grades.where(course: course).count
  end

  def is_studying?
    courses_studied.any?
  end

  def is_teaching?
    courses_taught.any?
  end

  def weighted_average
    arr = received_grades.where('value > 0').includes(:course)
    total_credits_count = arr.map{|c| c.course.credits}.inject{|sum,x| sum + x}

    total_grades = 0
    arr.each do |g|
      total_grades = total_grades + ( [g.value,4.0].max * g.course.credits/total_credits_count)
    end
    Grade.formatted_value(total_grades)
    # total_credits_count
  end

private

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64.gsub(/[^0-9a-zA-Z]/i, '')
    end while User.exists?(column => self[column])
  end

end
