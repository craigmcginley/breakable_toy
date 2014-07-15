require 'rails_helper'

feature "user deletes a family" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }

  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "admin")
    sign_in_as(user)
  end

  scenario "successfully" do
    click_link "My Families"

    click_link "Delete #{family.surname} Family"

    expect(page).to have_content("Family deleted.")
    expect(page).to_not have_content("family.surname")
  end

end
