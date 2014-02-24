require 'spec_helper'

describe "EditProfile" do
  context "My Account page" do
    before do
      @user = FactoryGirl.create(:user, email: "drew@example.com")
      sign_in_user(@user)
      click_link('My Account')
    end
    it "should be on the Edit User page" do
      page.should have_content('Edit User')
    end
    it "should throw error if no first name" do
      fill_in('First name', :with => '')
      click_button('Update')
      page.should have_content('First name can\'t be blank')
    end
    it "should throw error if no last name" do
      fill_in('Last name', :with => '')
      click_button('Update')
      page.should have_content('Last name can\'t be blank')
    end
    it "should throw error if no email" do
      fill_in('Email', :with => '')
      click_button('Update')
      page.should have_content('Email can\'t be blank')
    end
    it "should throw error if current password is not given" do
      fill_in('First name', :with => 'Dave')
      click_button('Update')
      page.should have_content('Current password can\'t be blank')
    end
    it "should reflect name change on user page" do
      fill_in('First name', :with => 'Eddard')
      fill_in('Last name', :with => 'Stark')
      fill_in('Current password', :with => "password")
      click_button('Update')
      page.should have_content('You updated your account successfully.')
      page.should have_content('Eddard Stark')
      page.should_not have_content('Jon Snow')
    end
  end
end