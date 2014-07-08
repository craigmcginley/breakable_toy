require 'rails_helper'

feature "user views index" do

  scenario "sees list of posts" do
    posts = FactoryGirl.create_list(:post, 5)

    visit root_path

    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.user.first_name)
    end
  end

end
