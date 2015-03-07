class CreateProgramStudents < ActiveRecord::Migration
  def change
    create_table :program_students do |t|
      t.references :user
      t.references :program

      t.timestamps null: false
    end
    add_index :program_students, [:user_id, :program_id], unique: true
    add_foreign_key :program_students, :users
    add_foreign_key :program_students, :programs
  end
end
