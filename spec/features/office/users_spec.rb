require 'rails_helper'

feature User do

  let!(:admin) { create(:user, email: 'john@iaac.net') }
  let!(:user) { create(:user, first_name: 'homer', last_name: 'simpson') }

  before(:each) do
    admin.update_attribute(:invitation_code, nil)
  end

  it "lists users" do
    login admin
    visit office_users_path
    expect(page).to have_title("Users")
    expect(page).to have_link("homer simpson")
  end

end
