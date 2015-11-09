class AddFieldsToLabs < ActiveRecord::Migration
  def change
    change_table :labs do |t|
      t.column :city, :string
      t.column :country, :string
    end
  end
end
