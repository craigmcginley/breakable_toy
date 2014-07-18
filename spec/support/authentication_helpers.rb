module Helpers
  module Authentication
    def sign_in_as(user)
      visit unauthenticated_root_path
      click_link "Sign In"

      within(".sign-in-modal") do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end
    end
  end
end
