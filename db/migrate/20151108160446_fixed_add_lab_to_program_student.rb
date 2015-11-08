class FixedAddLabToProgramStudent < ActiveRecord::Migration
  def change
    change_table :program_students do |t|
      t.belongs_to :lab
    end

    add_foreign_key :program_students, :labs

  end
end
