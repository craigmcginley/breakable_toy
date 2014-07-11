require 'rails_helper'

feature "user invites a non-user to join site/family" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }

  before(:each) do
    sign_in_as(user)
    visit new_family_path

    fill_in "Surname", with: family.surname
    click_button "Create Family"
  end

  scenario "with valid info" do
    click_link "Manage Invites"

    fill_in "Name", with: "Craig"
    fill_in "Email", with: "craig@example.com"
    click_button "Invite"

    expect(Invitee.count).to eq(1)
    expect(page).to have_content("Successfully Invited!")
    expect(page).to have_content("craig@example.com")
    expect(page).to have_content(family.surname)
    expect(page).to have_content("pending")
  end

  scenario "without any info" do
    click_link "Manage Invites"
    click_button "Invite"

    expect(Invitee.count).to eq(0)
    expect(page).to have_content("Please check the requirements")
    expect(page).to have_content("can't be blank")
  end

end
