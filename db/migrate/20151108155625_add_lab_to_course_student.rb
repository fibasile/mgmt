class AddLabToCourseStudent < ActiveRecord::Migration
  def change
    change_table :course_students do |t|
      t.belongs_to :lab
    end

    add_foreign_key :course_students, :labs

  end
end
