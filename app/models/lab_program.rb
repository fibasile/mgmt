class LabProgram < ActiveRecord::Base
  belongs_to :program
  belongs_to :lab
  
  #has_many :lab_program_tutors, dependent: :destroy
  
  def students_count
    ProgramStudent.where(lab_id: lab, program_id: program).count()
  end
  
  def guru  
    @guru = User.find(self.guru_id) if self.guru_id
  end

  def instructor
    @instructor = User.find(self.instructor_id) if self.instructor_id
  end

end
