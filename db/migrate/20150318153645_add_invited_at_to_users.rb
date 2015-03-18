class AddInvitedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invited_at, :datetime
  end
end
