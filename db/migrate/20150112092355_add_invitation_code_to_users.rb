class AddInvitationCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitation_code, :string, index: true
    User.all.each do |user|
      user.generate_token(:invitation_code)
      user.save!
    end
  end
end
