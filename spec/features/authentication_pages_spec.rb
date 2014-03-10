require 'spec_helper'

describe "Authentication pages" do

  context "finding authentication links" do
    it "should have a sign up link" do
      visit '/'
      find_link('Sign Up').visible?
    end
    it "should have a sign in link" do
      visit '/'
      find_link('Sign In').visible?
    end
  end

  context "signing up" do
    before do
      visit '/'
      click_link('Sign Up')
      fill_in('First name', :with => 'Drew')
      fill_in('Last name', :with => 'Example')
      fill_in('Email', :with => 'drew@example.com')
      fill_in('Password', :with => 'password')
      fill_in('Password confirmation', :with => 'password')
      click_button('Sign up')
    end
    it "should show success message after login" do
      page.should have_content('Welcome! You have signed up successfully.')
    end
    it "should have sign out link after sign up" do
      find_link('Sign Out').visible?
    end
    it "should have home link after sign up" do
      find_link('Home').visible?
    end
    it "should not have sign in link after sign up" do
      page.should_not have_content('Sign In')
    end
    it "should let you sign out after signing up" do
      click_link('Sign Out')
      page.should have_content('Sign In')
      page.should have_content('Signed out successfully.')
    end
  end

  context "signing in with email" do
    before do
      @user = FactoryGirl.create(:user, email: "drew@example.com")
      sign_in_user(@user)
    end
    it "should show the success message for signing in" do
      page.should have_content("Signed in successfully.")
    end
    it "should have sign out link after sign in" do
      find_link('Sign Out').visible?
    end
    it "should have the other links in nav" do
      find_link('Home').visible?
      find_link('All Users').visible?
      find_link('My Friends').visible?
      find_link('My Account').visible?
    end
    it "should not have sign in link after sign in" do
      page.should_not have_content('Sign In')
    end
    it "should let you sign out after signing in" do
      click_link('Sign Out')
      page.should have_content('Sign In')
      page.should have_content('Signed out successfully.')
    end
  end
end
