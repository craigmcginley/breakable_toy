require 'rails_helper'

feature "user edits a post" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family], user: user) }

  before(:each) do
    FactoryGirl.create(:family_post, family: family, post: post)
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    FactoryGirl.create(:family_member, family: family, user: user2, role: "member")
    sign_in_as(user)
  end

  scenario "with valid info" do
    visit post_path(post)
    click_link "Edit"

    fill_in "Title", with: "New Title"
    click_button "Update Post"

    expect(page).to have_content("Successfully updated.")
    expect(page).to have_content("New Title")
  end

  scenario "with invalid info" do
    visit edit_post_path(post)

    fill_in "Title", with: ""
    click_button "Update Post"

    expect(page).to have_content("Please check the requirements.")
    expect(page).to_not have_content("New Title")
  end

  scenario "prevents other user from editing" do
    click_link "Sign Out"
    sign_in_as(user2)
    visit post_path(post)

    expect(page).to_not have_link("Edit")
  end

end
