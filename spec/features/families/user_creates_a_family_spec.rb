require 'rails_helper'

feature "user creates a family" do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in_as(user)
  end

  scenario "with valid info" do
    visit root_path
    click_link "Create a Family"

    fill_in "Surname", with: "McGinley"
    click_button "Create Family"

    expect(Family.count).to eq(1)
    expect(FamilyMember.count).to eq(1)
    family_member = FamilyMember.first
    expect(family_member.role).to eq("admin")
    expect(page).to have_content("Created your family!")
    expect(page).to have_content("McGinley")
  end

  scenario "missing valid info" do
    visit new_family_path
    click_button "Create Family"

    expect(Family.count).to eq(0)
    expect(page).to_not have_content("Created your family!")
    expect(page).to have_content("can't be blank")
  end

end
