require 'spec_helper'

describe "Recommendations" do
  context "create recommendations" do
    before do
      @user = FactoryGirl.create(:user, email: "drew@example.com")
      @user2 = FactoryGirl.create(:user, email: "jim@example.com", first_name: "Jim")
      @friendship_for_user = FactoryGirl.create(:friendship, user: @user, friend: @user2, status: "accepted")
      @friendship_for_other_user = FactoryGirl.create(:friendship, user: @user2, friend: @user, status: "accepted")
      sign_in_user(@user)
      visit "/users/#{@user2.id}"
    end
    it "should display the add button on the friend's page" do
      find_button('Add').visible?
    end
    it "should have a form appear after clicking Add", js: true do
      click_button('Add')
      page.should have_content('Body')
      find_button('Recommend').visible?
    end
    it "should throw an error if a body is not added", js: true do
      click_button('Add')
      click_button('Recommend')
      page.should have_content('There was a problem creating your recommendation')
    end
    it "should give you a success message if a body is filled out", js: true do
      click_button('Add')
      fill_in "Body", with: "This is a test."
      click_button('Recommend')
      page.should have_content('Your recommendation has been created')
    end
    it "should contain the name of the creator and body of the message", js: true do
      click_button('Add')
      fill_in "Body", with: "This is a test."
      click_button('Recommend')
      page.should have_content('Jon Snow')
      page.should have_content('This is a test.')
    end
    it "should only contain the last three recommendations" do
      @rec = FactoryGirl.create(:recommendation, user: @user2, creator_id: @user.id, body: 'Rec 1')
      @rec2 = FactoryGirl.create(:recommendation, user: @user2, creator_id: @user.id, body: 'Rec 2')
      @rec3 = FactoryGirl.create(:recommendation, user: @user2, creator_id: @user.id, body: 'Rec 3')
      @rec4 = FactoryGirl.create(:recommendation, user: @user2, creator_id: @user.id, body: 'Rec 4')
      visit "/users/#{@user2.id}"
      page.should have_content('Rec 4')
      page.should have_content('Rec 3')
      page.should have_content('Rec 2')
      page.should_not have_content('Rec 1')
    end
  end
end