require 'rails_helper'

feature "user signs up" do

  scenario "with valid information" do
    visit root_path

    click_link "Sign Up"

    fill_in "user_first_name", with: "Craig"
    fill_in "user_last_name", with: "McGinley"
    fill_in "Email", with: "craig@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    attach_file('user_avatar', File.join(Rails.root, '/spec/fixtures/images/avatar.png'))
    click_button "Sign Up"

    expect(User.count).to eq(1)
    expect(page).to have_content "Welcome to the Fami.ly!"
    expect(page).to have_content "Sign Out"
  end

  scenario "without required information" do
    visit new_user_registration_path

    click_button "Sign Up"

    expect(User.count).to eq(0)
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
    expect(page).to_not have_content "Sign Out"
  end

end
