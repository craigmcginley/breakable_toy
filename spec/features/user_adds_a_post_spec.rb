require 'rails_helper'

feature "user adds a post" do

  scenario "with all information" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit root_path
    click_link "Add a Post"

    post = FactoryGirl.build(:post)
    fill_in "Title", with: post.title
    fill_in "Body", with: post.body
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.user.first_name)
  end

  scenario "with all information except description" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_post_path

    post = FactoryGirl.build(:post)
    fill_in "Title", with: post.title
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.user.first_name)
  end

  scenario "with a title that's too long" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_post_path

    fill_in "Title", with: 'Test Title' * 100
    click_button "Create Post"

    expect(page).to_not have_content("Post created!")
    expect(page).to have_content("Please check the requirements.")
    expect(page).to have_content("is too long (maximum is 255 characters)")
  end

  scenario "with no information" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_post_path
    click_button "Create Post"

    expect(page).to_not have_content("Post created!")
    expect(page).to have_content("Please check the requirements.")
    expect(page).to have_content("can't be blank")
  end
end
