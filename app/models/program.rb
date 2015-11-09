## this class represents a Class in our module (i.e. Fab Academy 2015)

class Program < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :program_students
  has_many :students, through: :program_students, source: :user
  has_many :lab_programs
  has_many :labs, through: :lab_programs ,source: :lab
  has_many :program_courses
  has_many :courses, through: :program_courses
  has_many :program_evaluators
  has_many :evaluators, through: :program_evaluators
  
  def to_s
    name
  end
end
