require 'spec_helper'

describe "UserProfiles" do
  before(:each) do
    @user = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
    sign_in_user(@user)
  end

  context "signed-in user home page" do
    it "should contain gravatar image" do
      gravatar_id = Digest::MD5.hexdigest(@user.email)
      page.should have_css("img[src='https://gravatar.com/avatar/#{gravatar_id}.png?s=150']")
    end

    it "should have the user name on the page" do
      page.should have_content('Jon Snow')
    end

    it "should have an edit user button" do
      find_button('Edit Profile').visible?
    end

    it "should send you to the Account page if you click edit button" do
      click_button('Edit Profile')
      page.should have_content('Edit User')
    end

    it "should have an Add Media button" do
      find_button('Add Media').visible?
    end

    it "should send you to the new Media page when clicking Add Media" do
      click_button('Add Media')
      page.should have_content('Add Media')
    end
  end

  context "Other user page" do
    before do
      @user2 = FactoryGirl.create(:user, email: "jdoe@email.com")
      visit "/users/#{@user2.id}"
    end

    it "should contain gravatar image" do
      gravatar_id = Digest::MD5.hexdigest(@user2.email)
      page.should have_css("img[src='https://gravatar.com/avatar/#{gravatar_id}.png?s=150']")
    end

    it "should have the user name on the page" do
      page.should have_content('Jon Snow')
    end
  end
end