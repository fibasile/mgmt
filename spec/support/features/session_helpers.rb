# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers

    def login(user = nil)
      user ||= create(:user)
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

  end
end
