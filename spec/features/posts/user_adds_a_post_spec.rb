require 'rails_helper'

feature "user adds a post" do
  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
  end

  scenario "with title and body information" do
    visit root_path
    click_link "Add a Post"

    post = FactoryGirl.build(:post)
    fill_in "post_title", with: post.title
    fill_in "Content", with: post.body
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.user.first_name)
  end

  scenario "with no description" do
    visit new_post_path

    post = FactoryGirl.build(:post)
    fill_in "post_title", with: post.title
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.user.first_name)
  end

  scenario "with a picture" do
    visit new_post_path

    post = FactoryGirl.build(:post)
    fill_in "post_title", with: post.title
    fill_in "Content", with: post.body
    attach_file('Picture', File.join(Rails.root, '/spec/fixtures/images/post_photo.jpg'))
    fill_in "Picture Title", with: "Family Pic!"
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    expect(page).to have_xpath("//img[contains(@src, 'post_photo.jpg' )]")
    expect(page).to have_content("Family Pic!")
  end

  scenario "with a video" do
    visit new_post_path

    post = FactoryGirl.build(:post)
    fill_in "post_title", with: post.title
    fill_in "Content", with: post.body
    fill_in "Link to YouTube Video", with: "https://www.youtube.com/watch?v=5NV6Rdv1a3I"
    fill_in "Video Title", with: "Recital"
    click_button "Create Post"

    expect(page).to have_content("Post created!")
    page.should have_css("iframe")
    expect(page).to have_content("Recital")
  end


  scenario "with a title that's too long" do
    visit new_post_path

    fill_in "post_title", with: 'Test Title' * 100
    click_button "Create Post"

    expect(page).to_not have_content("Post created!")
    expect(page).to have_content("Please check the requirements.")
    expect(page).to have_content("is too long (maximum is 255 characters)")
  end

  scenario "with no information" do
    visit new_post_path
    click_button "Create Post"

    expect(page).to_not have_content("Post created!")
    expect(page).to have_content("Please check the requirements.")
    expect(page).to have_content("can't be blank")
  end

end
