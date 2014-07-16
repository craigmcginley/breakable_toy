require 'rails_helper'

feature "user views index" do
  let(:user) { FactoryGirl.create(:user) }
  let(:family1) { FactoryGirl.create(:family) }
  let(:posts) { FactoryGirl.attributes_for_list(:post, 5) }

  before(:each) do
    sign_in_as(user)
    FactoryGirl.create(:family_member, family: family1, user: user)
    posts.each do |post|
      post[:user] = user
      visit new_post_path
      check(family1.surname)
      fill_in "post_title", with: post[:title]
      fill_in "Content", with: post[:body]
      click_button "Create Post"
    end
  end

  scenario "sees list of posts" do
    visit authenticated_root_path

    posts.each do |post|
      expect(page).to have_content(post[:title])
      expect(page).to have_content(post[:user].first_name)
    end
  end

end
