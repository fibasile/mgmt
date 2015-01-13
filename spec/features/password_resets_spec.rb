require 'rails_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = create(:user)
    visit login_path
    click_link "password"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Email sent")
    expect(last_email.to).to include(user.email)
  end

  it "does not email invalid user when requesting password reset" do
    visit login_path
    click_link "password"
    fill_in "Email", :with => "nobody@example.com"
    click_button "Reset Password"
    expect(current_path).to eq(password_resets_path)
    expect(page).to have_content("not found")
    expect(last_email).to be_nil
  end

  # I added the following specs after recording the episode. It literally
  # took about 10 minutes to add the tests and the implementation because
  # it was easy to follow the testing pattern already established.
  it "updates the user password when confirmation matches" do
    user = create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "New Password", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("confirmation doesn't match")
    fill_in "New Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Password has been reset")
  end

  it "reports when password token has expired" do
    user = create(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "New Password", :with => "foobar"
    fill_in "Password confirmation", :with => "foobar"
    click_button "Update Password"
    expect(page).to have_content("Password reset has expired")
  end

  it "raises record not found when password token is invalid" do
    expect {
      visit edit_password_reset_path("invalid")
    }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
