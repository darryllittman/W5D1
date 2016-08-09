require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "user"
    fill_in 'Password', with: "password"
    click_on "Create Account"
  end

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Create an Account"
  end

  feature "signing up a user" do

    scenario "shows goals on the homepage after signup" do
      expect(page).to have_content "Goals:"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "user"
    end
  end

  feature "with invalid user" do
    before(:each) do
      visit new_user_url
      fill_in "Username", with: "user"
      fill_in "Password", with: ""
      click_on "Create Account"
    end

    scenario "render the new account page on failed signup" do
      expect(page).to have_content "Create an Account"
    end
  end

  feature "logging in" do
    before(:each) do
      visit new_session_url
      fill_in 'Username', with: "user"
      fill_in 'Password', with: "password"
      click_on "Log In"
    end

    scenario "shows goals on the homepage after sign in" do
      expect(page).to have_content "Goals:"
    end

    scenario "shows username on the homepage after sign in" do
      expect(page).to have_content "user"
    end

    scenario "shows log out button on homepage after sign in when logged in" do
      expect(page).to have_button "Log Out"
    end
  end

  feature "logging out" do
    before(:each) do
      visit new_session_url
      fill_in 'Username', with: "user"
      fill_in 'Password', with: "password"
      click_on "Log In"
      click_on "Log Out"
    end

    scenario "doesn't show username on the homepage after logout" do
      expect(page).to have_content "Log In"
    end

    scenario "expect to be redireced to log in page" do
      expect(current_path).to eq(new_session_path)
    end
  end
end
