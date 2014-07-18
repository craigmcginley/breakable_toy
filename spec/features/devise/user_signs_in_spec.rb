require 'rails_helper'

feature "user signs in" do

  scenario "with valid credentials" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    expect(page).to have_content "You have signed in."
  end

  scenario "with invalid credentials" do
    visit new_user_session_path
    click_button "sign-in-button"

    expect(page).to have_content "Invalid email or password."
  end

end
