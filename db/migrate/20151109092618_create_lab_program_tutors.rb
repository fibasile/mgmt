class CreateLabProgramTutors < ActiveRecord::Migration
  def change
    create_table :lab_program_tutors do |t|

      t.timestamps null: false
    end
  end
end
