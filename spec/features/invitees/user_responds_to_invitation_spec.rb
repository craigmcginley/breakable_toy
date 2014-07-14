require 'rails_helper'

feature "user responds to invitation" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.build(:family) }

  before(:each) do
    ActionMailer::Base.deliveries = []

    sign_in_as(user1)
    visit new_family_path

    fill_in "Surname", with: family.surname
    click_button "Create Family"
    click_link "Manage Invites for #{family.surname} Family"
    fill_in "Name", with: user2.first_name
    fill_in "Email", with: user2.email
    click_button "Invite"
  end

  scenario "with accept" do
    click_link "Sign Out"
    sign_in_as(user2)

    click_link "My Invites"
    click_link "Accept"

    expect(FamilyMember.count).to eq(2)
    expect(page).to have_content("Accepted invitation!")
  end

  scenario "with decline" do
    click_link "Sign Out"
    sign_in_as(user2)

    click_link "My Invites"
    click_link "Decline"

    expect(FamilyMember.count).to eq(1)
    expect(page).to have_content("Declined invitation")
  end

end
