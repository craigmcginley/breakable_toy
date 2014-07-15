require 'rails_helper'

feature "user edits a family" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }

  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "admin")
    sign_in_as(user)
  end

  scenario "with valid info" do
    click_link "My Families"

    click_link "Edit #{family.surname} Family"

    fill_in "Surname", with: "McGinley"
    click_button "Update Family"

    expect(page).to have_content("Successfully updated.")
    expect(page).to have_content("McGinley")
  end

  scenario "with invalid info" do
    click_link "My Families"

    click_link "Edit #{family.surname} Family"

    fill_in "Surname", with: ""
    click_button "Update Family"

    expect(page).to have_content("Please check the requirements.")
    expect(page).to_not have_content("McGinley")
  end

end
