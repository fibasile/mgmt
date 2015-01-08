class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :subtitle
      t.text :description
      t.integer :credits
      t.boolean :published, default: false

      t.timestamps null: false
    end
  end
end
