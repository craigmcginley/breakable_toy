require 'rails_helper'

feature "user signs up" do

  scenario "with valid information" do
    visit new_user_registration_path

    fill_in "user_first_name", with: "Craig"
    fill_in "user_last_name", with: "McGinley"
    fill_in "Email", with: "craig@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_on "Sign Up"

    expect(page).to have_content "Welcome to the Fami.ly!"
  end

  scenario "without required information" do
    visit new_user_registration_path

    click_on "Sign Up"

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

end
