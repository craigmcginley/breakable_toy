require 'rails_helper'

feature "user edits a comment" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family]) }
  let!(:comment) { FactoryGirl.create(:comment, user: user, post: post) }

  before(:each) do
    FactoryGirl.create(:family_post, family: family, post: post)
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    FactoryGirl.create(:family_member, family: family, user: user2, role: "member")
    sign_in_as(user)
  end

  scenario "with valid info" do
    visit post_path(post)
    click_link "Edit"

    fill_in "comment_body", with: "New body!"
    click_button "Comment"

    expect(page).to have_content("Comment updated!")
    expect(page).to have_content("New body!")
  end

  scenario "with invalid info" do
    visit post_path(post)
    click_link "Edit"
    fill_in "comment_body", with: ""
    click_button "Comment"

    expect(page).to have_content("Please check the requirements.")
  end

  scenario "prevents other user from editing" do
    click_link "Sign Out"
    sign_in_as(user2)
    visit post_path(post)

    expect(page).to_not have_link("Edit")
  end

end
