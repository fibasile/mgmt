class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.belongs_to :course, null: false
      t.belongs_to :gradee, null: false
      t.belongs_to :grader
      t.integer :value
      t.text :public_notes
      t.text :private_notes
      t.datetime :approved_at
      t.datetime :viewed_at

      t.timestamps null: false
    end

    add_index :grades, [:course_id, :gradee_id], unique: true
    add_index :grades, :grader_id
    add_foreign_key :grades, :courses
    add_foreign_key :grades, :users, column: :grader_id
    add_foreign_key :grades, :users, column: :gradee_id
  end
end
