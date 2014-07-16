require 'rails_helper'

feature "family admin deletes a family member" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }

  before(:each) do
    FactoryGirl.create(:invitee, email: user2.email, family: family, status: "joined")
    FactoryGirl.create(:family_member, family: family, user: user1, role: "admin")
    FactoryGirl.create(:family_member, family: family, user: user2, role: "member")
    sign_in_as(user1)
  end

  scenario "successfully" do
    visit family_invitees_path(family)
    click_link "Remove"

    expect(page).to have_content("Family member removed.")
    expect(Invitee.count).to eq(0)
    expect(page).to_not have_content(user2.email)
  end

end
