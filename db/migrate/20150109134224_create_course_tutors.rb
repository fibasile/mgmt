class CreateCourseTutors < ActiveRecord::Migration
  def change
    create_table :course_tutors do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.string :role
      t.text :role_description

      t.timestamps null: false
    end
    add_index :course_tutors, [:course_id, :user_id], unique: true

    add_foreign_key :course_tutors, :users
    add_foreign_key :course_tutors, :courses
  end
end
