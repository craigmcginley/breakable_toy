require 'rails_helper'

feature "user deletes a comment" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family]) }
  let!(:comment) { FactoryGirl.create(:comment, user: user, post: post) }

  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "with valid info" do
    visit post_path(post)
    click_link "Delete"

    expect(page).to have_content("Comment deleted.")
    expect(page).to_not have_content(comment.body)
  end
end
