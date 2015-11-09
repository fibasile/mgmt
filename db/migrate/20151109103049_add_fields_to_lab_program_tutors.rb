class AddFieldsToLabProgramTutors < ActiveRecord::Migration
  def change
    change_table :lab_program_tutors do |t|
      t.belongs_to :lab_program
      t.belongs_to :user
      t.column :role, :string
    end
  end
end
