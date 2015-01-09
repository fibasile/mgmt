require 'rails_helper'
include Warden::Test::Helpers

feature Course do

  let(:user) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course, name: 'awesome course') }

  scenario "links to individual couse from course list" do
    course
    login_as user
    visit courses_path
    expect(page).to have_title("Courses")
    click_link("awesome course")
    expect(page).to have_title("awesome course")
  end

end
