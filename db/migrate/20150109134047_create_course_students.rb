class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.timestamps null: false
    end

    add_index :course_students, [:course_id, :user_id], unique: true

    add_foreign_key :course_students, :users
    add_foreign_key :course_students, :courses
  end
end
