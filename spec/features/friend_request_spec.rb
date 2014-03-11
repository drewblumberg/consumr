require 'spec_helper'

describe "FriendRequests" do
  before(:each) do
    @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
    @user2 = FactoryGirl.create(:user, email: "jdoe@email.com", first_name: "Jim")
    sign_in_user(@user1)
  end

  context "New friend request" do
    before do
      visit "users/#{@user2.id}"
    end
    it "should have a request friend link when there is no relationship" do
      find_link("Request Friendship").visible?
    end

    it "should give you a success message when clicking on the request friend link" do
      click_link("Request Friendship")
      page.should have_content("Friendship requested with Jim Snow")
    end

    it "should redirect you to the user's profile page" do
      click_link("Request Friendship")
      page.should have_content("Jim Snow")
    end

    it "should have a note that you are pending friends" do
      click_link("Request Friendship")
      page.should have_content("Pending Friends")
    end

    it "should say Requested Friends for the other user" do
      click_link("Request Friendship")
      click_link("Sign Out")
      sign_in_user(@user2)
      visit "users/#{@user1.id}"
      page.should have_content("Requested Friends")
    end
  end

  context "Accepting Friend Requests" do
    before do
      visit "users/#{@user2.id}"
      click_link("Request Friendship")
      click_link("Sign Out")
      sign_in_user(@user2)
      click_link("My Friends")
    end

    it "should have an accept friend link within the requests div" do
      within("div[id=friend_requests]") do
        find_link("Accept").visible?
      end
    end

    it "should give success message when clicking accept" do
      click_link("Accept")
      page.should have_content("Friendship accepted with Jon Snow")
    end

    it "should say Accepted Friends on the user's page" do
      click_link("Accept")
      visit "/users/#{@user1.id}"
      page.should have_content("Accepted Friends")
    end

    it "should say Accepted Friends for the other user looking at your user page" do
      click_link("Accept")
      click_link("Sign Out")
      sign_in_user(@user1)
      visit "/users/#{@user2.id}"
      page.should have_content("Accepted Friends")
    end
  end

  context "Rejecting Friend Requests" do
    before do
      visit "users/#{@user2.id}"
      click_link("Request Friendship")
      click_link("Sign Out")
      sign_in_user(@user2)
      click_link("My Friends")
    end

    it "should have a reject friend link within the requests div" do
      within("div[id=friend_requests]") do
        find_link("Reject").visible?
      end
    end

    it "should give success message when clicking reject" do
      click_link("Reject")
      page.should have_content("Friendship rejected with Jon Snow")
    end

    it "should say Accepted Friends on the user's page" do
      click_link("Reject")
      visit "/users/#{@user1.id}"
      find_link("Request Friendship").visible?
    end

    it "should have the request link for the other user looking at your user page" do
      click_link("Reject")
      click_link("Sign Out")
      sign_in_user(@user1)
      visit "/users/#{@user2.id}"
      find_link("Request Friendship").visible?
    end
  end
end