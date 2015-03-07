require 'rails_helper'

feature Course do

  let!(:admin) { create(:user, email: 'john@iaac.net') }
  let!(:course) { create(:course, name: 'awesome course') }

  before(:each) do
    admin.update_attribute(:invitation_code, nil)
  end

  it "lists courses" do
    login admin
    visit office_root_path
    click_link "Courses"
    expect(current_path).to eq(office_courses_path)
    expect(page).to have_title("Courses")
    expect(page).to have_link("awesome course")
  end

  it "can add course" do
    login admin
    visit office_courses_path
    click_link "Create a new Course"
    fill_in "Name", with: "New Name"
    click_button "Create Course"
    expect(page).to have_title("New Name")
  end

  it "can edit course" do
    login admin
    visit office_course_path(course)
    click_link "Edit Course"
    fill_in "Name", with: "awesome course2"
    click_button "Update Course"
    expect(page).to have_title("awesome course2")
  end

end
