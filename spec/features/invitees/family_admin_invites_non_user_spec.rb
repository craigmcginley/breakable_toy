require 'rails_helper'

feature "user invites a non-user to join site/family" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }

  before(:each) do
    ActionMailer::Base.deliveries = []

    sign_in_as(user)
    visit new_family_path

    fill_in "Surname", with: family.surname
    click_button "Create Family"
  end

  scenario "with valid info" do
    within(".family-actions") do
      click_link "Manage"
    end
    within(".invite-form") do
      fill_in "Name", with: "Craig"
      fill_in "Email", with: "craig@example.com"
      click_button "Invite"
    end

    expect(Invitee.count).to eq(1)
    expect(page).to have_content("Successfully Invited!")
    expect(page).to have_content("craig@example.com")
    expect(page).to have_content(family.surname)
    expect(page).to have_content("pending")

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.last
    expect(email).to have_subject("Invitation from #{user.first_name} to join a kinstagram family")
    expect(email).to deliver_to("craig@example.com")
    expect(email).to have_body_text("#{user.first_name} #{user.last_name} has invited you to join their family group on kinstagram. Register or sign in to accept this invitation.")
  end

  scenario "without any info" do
    within(".family-actions") do
      click_link "Manage"
    end
    within(".invite-form") do
      click_button "Invite"
    end



    expect(Invitee.count).to eq(0)
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(page).to have_content("Please check the requirements")
    expect(page).to have_content("can't be blank")
  end

  scenario "with someone who has already been invited" do
    invitee = FactoryGirl.attributes_for(:invitee)
    within(".family-actions") do
      click_link "Manage"
    end
    within(".invite-form") do
      fill_in "Name", with: invitee[:name]
      fill_in "Email", with: invitee[:email]
      click_button "Invite"
    end

    within(".invite-form") do
      fill_in "Name", with: invitee[:name]
      fill_in "Email", with: invitee[:email]
      click_button "Invite"
    end

    expect(Invitee.count).to eq(1)
    expect(page).to have_content("This invite already exists.")
  end

end
