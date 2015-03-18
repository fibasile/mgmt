class AddCountsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :students_counter_cache, :integer, default: 0, null: false
    add_column :courses, :grades_counter_cache, :integer, default: 0, null: false

    CourseStudent.counter_culture_fix_counts
    Grade.counter_culture_fix_counts
    # Course.all.each do |course|
    #   course.update_attribute(:students_count, course.course_students.count)
    #   course.update_attribute(:grades_count, course.grades.where('value > 0 AND value <= 10').count)
    # end
  end
end
