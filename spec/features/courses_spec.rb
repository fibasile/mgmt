require 'rails_helper'

feature Course do

  let(:user) { create(:user) }
  let(:course) { create(:course, name: 'awesome course') }

  scenario "links to individual couse from course list" do
    course
    login user
    visit courses_path
    expect(page).to have_title("Courses")
    click_link("awesome course")
    expect(page).to have_title("awesome course")
  end

end
