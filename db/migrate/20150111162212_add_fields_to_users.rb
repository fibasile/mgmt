class AddFieldsToUsers < ActiveRecord::Migration
  def up
    enable_extension :hstore

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :country_code, :string
    add_column :users, :photo, :string
    add_column :users, :description, :text
    add_column :users, :gender, :string
    add_column :users, :dob, :date
    add_column :users, :meta, :hstore
  end

  def down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :country_code, :string
    remove_column :users, :photo, :string
    remove_column :users, :description, :text
    remove_column :users, :gender, :string
    remove_column :users, :dob, :date
    remove_column :users, :meta, :hstore

    disable_extension :hstore
  end
end
