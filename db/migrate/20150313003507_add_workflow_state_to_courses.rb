class AddWorkflowStateToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :workflow_state, :string
    add_index :courses, :workflow_state

    Course.all.each do |course|
      if (course.grades_remaining == course.students.count)
        if (course.students.count > 0)
          course.update_attribute(:workflow_state, :graded)
        else
          course.update_attribute(:workflow_state, :published)
        end
      else
        course.update_attribute(:workflow_state, :being_graded)
      end
    end

  end
end
