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
  end
end