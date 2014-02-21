require 'spec_helper'

describe "UserProfiles" do

  context "signed-in user home page" do
    before do
      @user = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
      visit '/'
      click_link('Sign In')
      fill_in('Email', :with => 'alblumberg21@gmail.com')
      fill_in('Password', :with => 'password')
      click_button("Sign in")
    end

    it "should contain gravatar image" do
      gravatar_id = Digest::MD5.hexdigest(@user.email)
      page.should have_css("img[src='https://gravatar.com/avatar/#{gravatar_id}.png?s=150']")
    end
  end
end