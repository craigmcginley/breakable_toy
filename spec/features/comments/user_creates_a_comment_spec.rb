require 'rails_helper'

feature "user creates a comment" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family) { FactoryGirl.create(:family) }
  let!(:post) { FactoryGirl.create(:post, families: [family]) }
  let(:comment) { FactoryGirl.attributes_for(:comment) }

  before(:each) do
    FactoryGirl.create(:family_member, family: family, user: user, role: "member")
    sign_in_as(user)
  end

  scenario "with valid info" do
    visit post_path(post)

    fill_in "comment_body", with: comment[:body]
    click_button "Comment"

    expect(page).to have_content("Comment added!")
    expect(page).to have_content(comment[:body])
  end

  scenario "with invalid info" do
    visit post_path(post)
    click_button "Comment"

    expect(page).to have_content("Please check the requirements.")
    expect(page).to_not have_content(comment[:body])
  end

end
