class DropGradesIndex < ActiveRecord::Migration
  def change
    remove_index :grades, [:course_id, :gradee_id]
    add_index :grades, [:course_id, :gradee_id, :grader_id]
  end
end
