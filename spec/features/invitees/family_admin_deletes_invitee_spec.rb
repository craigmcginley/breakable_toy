require 'rails_helper'

feature "family admin removes invitee" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.build(:family) }

  before(:each) do
    ActionMailer::Base.deliveries = []

    sign_in_as(user1)
    visit new_family_path

    fill_in "Surname", with: family.surname
    click_button "Create Family"
    click_link "Manage"
    fill_in "Name", with: user2.first_name
    fill_in "Email", with: user2.email
    click_button "Invite"
  end

  scenario "successfully" do
    click_link "Remove"

    expect(page).to have_content("Successfully removed invitation.")
    expect(page).to_not have_content(user2.email)
  end

end
