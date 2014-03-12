require 'spec_helper'

describe "All Recommendations Page" do
  before do
    @user = FactoryGirl.create(:user, email: "drew@example.com")
    @user2 = FactoryGirl.create(:user, email: "jim@example.com", first_name: "Jim")
    FactoryGirl.create(:friendship, user: @user, friend: @user2, status: "accepted")
    FactoryGirl.create(:friendship, user: @user2, friend: @user, status: "accepted")
    5.times do
      FactoryGirl.create(:recommendation, user: @user, creator_id: @user2.id, body: Faker::Lorem.sentence)
    end
    sign_in_user(@user)
  end
  context "link to page" do
    it "should appear for current user on user's profile" do
      find_link("All Recommendations").visible?
    end
    it "should not appear on a different user's profile" do
      visit "/users/#{@user2.id}"
      page.should_not have_css('a[href="/recommendations"]')
    end
  end
  context "layout" do
    before do
      click_link("All Recommendations")
    end
    it "should have header" do
      page.should have_content('All Recommendations')
    end
    it "should have 5 delete buttons" do
      page.should have_css('.button_to', count: 5)
    end
  end
  context "deleting recommendations" do
    before do
      click_link("All Recommendations")
      first('input[value="X"]').click
    end
    it "should display a success message upon deletion" do
      page.should have_content('Your recommendation was successfully deleted')
    end
    it "should now only have 4 recommendations" do
      page.should have_css('.button_to', count: 4)
    end
  end
end