class CreateProgramCourses < ActiveRecord::Migration
  def change
    create_table :program_courses do |t|
      t.belongs_to :program
      t.belongs_to :course
      t.integer :credits
      t.boolean :published, default: false, null: false

      t.timestamps null: false
    end
    add_index :program_courses, [:program_id, :course_id], unique: true
    add_index :program_courses, :published
    add_foreign_key :program_courses, :programs
    add_foreign_key :program_courses, :courses
  end
end
