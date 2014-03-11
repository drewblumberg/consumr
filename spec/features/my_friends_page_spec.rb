require 'spec_helper'

describe "My Friends Page" do
  before(:each) do
    @user = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
    @user2 = FactoryGirl.create(:user, email: "jdoe@email.com", first_name: "Jim")
    FactoryGirl.create(:friendship, user: @user, friend: @user2, status: "accepted")
    FactoryGirl.create(:friendship, user: @user2, friend: @user, status: "accepted")
    sign_in_user(@user)
    visit "/friendships/my_friends"
  end
  context "All friends list" do
    it "should have my friends header" do
      page.should have_content('My Friends')
    end
    it "should have friends requests header" do
      page.should have_content("Friend Requests")
    end
    it "should have pending friends header" do
      page.should have_content("Pending Friends")
    end
    it "should have all friends header" do
      page.should have_content("All Friends")
    end
    it "should have pagination" do
      page.has_css?('div.pagination')
    end
    it "should have jim on the All Friends list" do
      within(:css, '#all_friends') do
        page.should have_content('Jim Snow')
      end
    end
  end
end