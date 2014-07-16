require 'rails_helper'

feature "admin deletes a post" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, user: user2, families: [family]) }


  before(:each) do
    FactoryGirl.create(:family_post, family: family, post: post)
    FactoryGirl.create(:family_member, family: family, user: user2, role: "member")
    FactoryGirl.create(:family_member, family: family, user: user, role: "admin")
    sign_in_as(user)
  end

  scenario "successfully" do
    visit posts_path
    click_link "Delete"

    expect(page).to have_content("Post deleted.")
    expect(page).to_not have_content(post.title)
  end

end
