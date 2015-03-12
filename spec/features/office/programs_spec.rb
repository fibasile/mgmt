require 'rails_helper'

feature Program do

  let!(:admin) { create(:user, email: 'john@iaac.net', clearance: 5) }
  let!(:program) { create(:program, name: 'maa04') }

  before(:each) do
    admin.update_attribute(:invitation_code, nil)
  end

  it "lists programs" do
    login admin
    visit office_root_path
    click_link("Programs")
    expect(current_path).to eq(office_programs_path)
    expect(page).to have_title("Programs")
    expect(page).to have_link("maa04")
  end

  it "can add program" do
    login admin
    visit office_programs_path
    click_link("Create a new Program")
    fill_in "Name", with: "New Name"
    click_button "Create Program"
    expect(page).to have_title("New Name")
  end

  it "can edit program" do
    login admin
    visit office_program_path(program)
    click_link("Edit Program")
    fill_in "Name", with: "awesome program2"
    click_button "Update Program"
    expect(page).to have_title("awesome program2")
  end

  it "can remove program" do
    login admin
    visit edit_office_program_path(program)
    click_link "Remove Program"
    # expect(page).to have_content("deleted")
    expect(current_path).to eq(office_programs_path)
    expect(current_path).to_not have_link('maa04')
  end

end
