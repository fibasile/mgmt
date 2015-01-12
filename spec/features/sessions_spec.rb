require 'rails_helper'

feature "Sessions" do

  let(:user) { create(:user) }

  context "as a valid user" do

    it "can login" do
      user
      visit login_path
      expect(page).to_not have_link("Logout")
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      expect(page).to have_link("Logout")
    end

    it "can logout" do
      login user
      click_link "Logout"
      expect(page).to have_button("Log in")
    end

  end

  context "as an invalid user" do

    it "cannot login" do
      visit login_path
      fill_in "Email", with: 'blah blah blah'
      click_button "Log in"
      expect(page).to have_content("Invalid")
    end

  end

end
