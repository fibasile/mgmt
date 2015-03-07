class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.date :starts_on
      t.date :ends_on

      t.timestamps null: false
    end
  end
end
