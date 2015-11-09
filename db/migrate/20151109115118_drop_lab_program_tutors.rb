class DropLabProgramTutors < ActiveRecord::Migration
  def change
     drop_table :lab_program_tutors
  end
end
