require 'rails_helper'

feature User do

  let!(:admin) { create(:user, email: 'john@iaac.net', clearance: 5) }
  let!(:user) { create(:user, first_name: 'homer', last_name: 'simpson') }

  before(:each) do
    admin.update_attribute(:invitation_code, nil)
  end

  it "lists users" do
    login admin
    visit office_root_path
    click_link("People")
    expect(current_path).to eq(office_users_path)
    expect(page).to have_title("People")
    expect(page).to have_link("homer simpson")
  end

end
