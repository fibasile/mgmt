class AddGroupToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :group, :string
    add_index :grades, :group
  end
end
