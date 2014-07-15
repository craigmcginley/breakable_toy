require 'rails_helper'

feature "user deletes a family" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family], user: user) }


  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "successfully" do
    visit posts_path
    click_link "Edit"

    click_link "Delete This Post"

    expect(page).to have_content("Post deleted.")
    expect(page).to_not have_content(post.title)
  end

end
