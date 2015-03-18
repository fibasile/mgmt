class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.grader_id_was and record.grader_id != record.grader_id_was
      old_grader = User.find(record.grader_id_was)
      record.errors[:base] = "#{old_grader} has already graded this student"
    end
  end
end

class Grade < ActiveRecord::Base

  HUMAN_GRADE = ['FAIL','FAIL','FAIL','FAIL','INCOMPLETE','LOW PASS', 'LOW PASS', 'PASS', 'PASS', 'HIGH PASS', 'HIGH PASS']

  validates_with MyValidator

  belongs_to :course
  belongs_to :grader, class_name: "User"
  belongs_to :gradee, class_name: "User"

  counter_culture :course,
    column_name: Proc.new {|model| model.value.present? and (model.value > 0 and model.value <= 10) ? 'grades_counter_cache' : nil },
    column_names: {
      ["grades.value > ?", 0] => 'grades_counter_cache'
    }

  validates_presence_of :course, :gradee
  validates_numericality_of :value, greater_than: 0, less_than_or_equal_to: 10, allow_nil: true
  # validates_uniqueness_of :gradee, scope: [:course, :grader]

  def formatted_grade
    Grade.formatted_value(self.value)
  end

  def human_grade
    Grade.human_grade_for value
  end

  def self.human_grade_for val
    val ? HUMAN_GRADE[val.floor] : "NOT GRADED"
  end

  def to_s
    Grade.formatted_value(value)
  end

  def self.formatted_value val=nil
    val ? sprintf('%.2f', val) : ""
  end

end
