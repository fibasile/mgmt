class AddAnnouncedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :announced_at, :datetime
  end
end
