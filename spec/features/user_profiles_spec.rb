require 'spec_helper'

describe "UserProfiles" do

  context "signed-in user home page" do
    before do
      @user = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
      sign_in_user(@user)
    end

    it "should contain gravatar image" do
      gravatar_id = Digest::MD5.hexdigest(@user.email)
      page.should have_css("img[src='https://gravatar.com/avatar/#{gravatar_id}.png?s=150']")
    end

    it "should have the user name on the page" do
      page.should have_content('Jon Snow')
    end
  end
end