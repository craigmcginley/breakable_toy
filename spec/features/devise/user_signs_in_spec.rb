require 'rails_helper'

feature "user signs in" do

  scenario "with valid credentials" do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content "You have signed in."
  end

  scenario "with invalid credentials" do
    visit new_user_session_path
    click_button "Sign In"

    expect(page).to have_content "Invalid email or password."
  end

end
