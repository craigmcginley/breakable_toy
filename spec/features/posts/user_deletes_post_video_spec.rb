require 'rails_helper'

feature "user deletes a post video" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family], user: user) }


  before(:each) do
    FactoryGirl.create(:post_video, post: post)
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "successfully" do
    visit posts_path
    click_link "Edit"

    click_link "Delete"

    expect(page).to have_content("Video removed.")
    page.should_not have_css("iframe")
  end

end
