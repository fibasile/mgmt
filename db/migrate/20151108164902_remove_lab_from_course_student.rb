class RemoveLabFromCourseStudent < ActiveRecord::Migration
  def change
    remove_column :course_students, :lab_id
  end
end
