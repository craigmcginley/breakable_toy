require 'rails_helper'

feature "user deletes a post" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family], user: user) }


  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "successfully" do
    visit edit_post_path(post)

    click_link "Delete This Post"

    expect(page).to have_content("Post deleted.")
    expect(page).to_not have_content(post.title)
  end

  scenario "fail to delete another users post" do
    other_comment = FactoryGirl.create(:comment, post: post)

    visit post_path(post)
    expect(page).to_not have_css('div.comment', text: "Edit")
  end

end
