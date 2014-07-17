require 'rails_helper'

feature "user invites a current user to join family" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.attributes_for(:family) }

  before(:each) do
    ActionMailer::Base.deliveries = []

    sign_in_as(user)
    visit new_family_path

    fill_in "Surname", with: family[:surname]
    click_button "Create Family"
  end

  scenario "who is not already a member" do
    click_link "Manage"

    fill_in "Name", with: user2.first_name
    fill_in "Email", with: user2.email
    click_button "Invite"

    expect(Invitee.count).to eq(1)
    expect(page).to have_content("Successfully Invited!")
    expect(page).to have_content(user2.email)
    expect(page).to have_content(family[:surname])
    expect(page).to have_content("pending")

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.last
    expect(email).to have_subject("Invitation from #{user.first_name} to join a kinstagram family")
    expect(email).to deliver_to(user2.email)
    expect(email).to have_body_text("#{user.first_name} #{user.last_name} has invited you to join their family group on kinstagram. Register or sign in to accept this invitation.")
  end

  scenario "who is already a member" do
    family1 = Family.where(surname: family[:surname]).first
    FactoryGirl.create(:family_member, family: family1, user: user2)
    click_link "Manage"
    fill_in "Name", with: user2.first_name
    fill_in "Email", with: user2.email
    click_button "Invite"

    expect(Invitee.count).to eq(0)
    expect(page).to have_content("This family member already exists.")
  end

end
