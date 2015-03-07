class AddAncestryToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :ancestry, :string
    add_index :courses, :ancestry
  end
end
