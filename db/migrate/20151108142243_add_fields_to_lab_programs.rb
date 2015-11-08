class AddFieldsToLabPrograms < ActiveRecord::Migration
  def change
    change_table "lab_programs" do |t|
             t.references :lab
             t.references :program
    end
    add_index :lab_programs, [:lab_id, :program_id], unique: true
    add_foreign_key :lab_programs, :labs
    add_foreign_key :lab_programs, :programs
  end
end
