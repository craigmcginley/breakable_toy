require 'rails_helper'

feature "user deletes a post image" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family], user: user) }


  before(:each) do
    FactoryGirl.create(:post_image, post: post)
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "successfully" do
    visit edit_post_path(post)
    click_link "Delete"

    expect(page).to have_content("Image deleted.")
    expect(page).to_not have_xpath("//img[contains(@src, 'post_photo.jpg' )]")
  end

end
