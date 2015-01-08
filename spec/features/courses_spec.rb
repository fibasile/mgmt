require 'rails_helper'
include Warden::Test::Helpers

feature Course do

  scenario "lists courses" do
    login_as FactoryGirl.create(:user)
    visit '/courses'
    expect(page).to have_title("Courses")
  end

end
