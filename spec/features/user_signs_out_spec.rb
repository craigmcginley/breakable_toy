require 'rails_helper'

feature "user signs out" do

  scenario "successfully" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    click_link "Sign Out"

    expect(page).to have_content "You have signed out."
  end
end
