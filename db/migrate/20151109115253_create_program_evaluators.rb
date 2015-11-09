class CreateProgramEvaluators < ActiveRecord::Migration
  def change
    create_table :program_evaluators do |t|
      t.belongs_to :program
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
