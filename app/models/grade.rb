class Grade < ActiveRecord::Base

  HUMAN_GRADE = ['FAIL','FAIL','FAIL','FAIL','INCOMPLETE','LOW PASS', 'LOW PASS', 'PASS', 'PASS', 'HIGH PASS', 'HIGH PASS']

  belongs_to :course
  belongs_to :grader, class_name: "User"
  belongs_to :gradee, class_name: "User"

  validates_presence_of :course, :gradee
  validates_uniqueness_of :gradee, scope: :course

  def human_grade
    Grade.human_grade_for value
  end

  def self.human_grade_for val
    val ? HUMAN_GRADE[val.floor] : "NOT GRADED"    
  end

  def self.formatted_value val=nil
    val ? sprintf('%.2f', val) : "-"
  end

end