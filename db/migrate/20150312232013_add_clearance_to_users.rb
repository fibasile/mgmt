class AddClearanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :clearance, :integer, default: 0
    add_index :users, :clearance
  end
end
