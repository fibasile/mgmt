class AddCourseTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :course_type, :integer
  end
end
