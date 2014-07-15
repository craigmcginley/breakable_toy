require 'rails_helper'

feature "family admin promotes a family member" do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:membership) { FactoryGirl.create(:family_member, family: family, user: user2, role: "member") }

  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user1, role: "admin")
    sign_in_as(user1)
  end

  scenario "successfully" do
    visit family_invitees_path(family)
    click_link "Promote"
    membership.reload
    expect(page).to have_content("Family member promoted!")
    expect(membership.role).to eq("admin")
  end

end
