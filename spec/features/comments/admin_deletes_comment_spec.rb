require 'rails_helper'

feature "admin deletes a comment" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family]) }
  let!(:comment) { FactoryGirl.create(:comment, user: user, post: post) }

  before(:each) do
    FactoryGirl.create(:family_post, family: family, post: post)
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    FactoryGirl.create(:family_member, family: family, user: user2, role: "admin")
    sign_in_as(user2)
  end

  scenario "successfully" do
    visit post_path(post)
    within(".delete-comment") do
      click_link "Delete"
    end

    expect(page).to have_content("Comment deleted.")
    expect(page).to_not have_content(comment.body)
  end

end
