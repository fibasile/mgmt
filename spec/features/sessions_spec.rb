require 'rails_helper'

feature "Sessions" do

  let(:user) { create(:user, email: 'homer@springfieldnuclear.com') }

  scenario "logging in" do
    user
    visit login_path
    expect(page).to_not have_link("Logout")
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_link("Logout")
  end

  scenario "logging out" do
    login user
    click_link "Logout"
    expect(page).to have_button("Log in")
  end

  scenario "logging in with ugly email" do
    visit login_path
    fill_in "Email", with: ' HOMER@springfieldnuclear.com  '
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_link("Logout")
  end

  scenario "logging in with invalid attributes" do
    visit login_path
    fill_in "Email", with: 'blah blah blah'
    click_button "Log in"
    expect(page).to have_content("Invalid")
  end

end
