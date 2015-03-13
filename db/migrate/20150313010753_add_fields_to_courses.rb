class AddFieldsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :starts_on, :date
  end
end
