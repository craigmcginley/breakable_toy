require 'rails_helper'

feature "user edits a post" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family], user: user) }

  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "with valid info" do
    visit posts_path
    click_link "Edit"

    fill_in "Title", with: "New Title"
    click_button "Update Post"

    expect(page).to have_content("Successfully updated.")
    expect(page).to have_content("New Title")
  end

  scenario "with invalid info" do
    visit posts_path
    click_link "Edit"

    fill_in "Title", with: ""
    click_button "Update Post"

    expect(page).to have_content("Please check the requirements.")
    expect(page).to_not have_content("New Title")
  end

end
