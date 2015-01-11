class AddTempDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :temp_data, :hstore
  end
end
