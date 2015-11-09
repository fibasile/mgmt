class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.string :description
      t.string :logo_url
      t.timestamps null: false
    end
  end
end
