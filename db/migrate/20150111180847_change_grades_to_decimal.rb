class ChangeGradesToDecimal < ActiveRecord::Migration
  def change
    change_column :grades, :value, :decimal, precision: 6, scale: 2
  end
end
