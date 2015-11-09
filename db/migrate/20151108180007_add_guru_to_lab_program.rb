class AddGuruToLabProgram < ActiveRecord::Migration
  def change
        add_column :lab_programs, :instructor_id,:integer
        add_column :lab_programs, :guru_id,:integer
  end
end
