require 'rails_helper'

feature "Invites" do

  let(:user) { create(:user) }

  scenario "coming from invitation email" do
    user.update_attribute(:invitation_code, 'whatever')
    visit invite_path(invitation_code: 'whatever')
    expect(page).to have_link("Logout")
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Update"
    expect(page).to have_content("Details updated successfully")
    expect(page).to_not have_button("Update")
  end

  scenario "incorrect invitation code" do
    visit invite_path(invitation_code: 'incorrect')
    expect(page).to have_content("User not found")
  end

  scenario "empty invitation code" do
    expect{
      visit invite_path
    }.to raise_error(ActionController::UrlGenerationError)
  end

  scenario "correct invitation code, incorrect password" do
    user.update_attribute(:invitation_code, 'whatever')
    visit invite_path(invitation_code: 'whatever')
    fill_in "Password", with: 'password'
    click_button "Update"
    expect(page).to have_content("doesn't match Password")
    expect(page).to have_button("Update")
  end

  scenario "correct invitation code, visiting other page" do
    user.update_attribute(:invitation_code, 'whatever')
    visit invite_path(invitation_code: 'whatever')
    visit login_path
    expect(page).to have_content("check and update your details first")
    visit report_card_path
    expect(page).to have_content("check and update your details first")
    expect(page).to have_button("Update")
  end

end
