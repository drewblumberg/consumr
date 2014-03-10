require 'spec_helper'

describe "All Users Page" do
  before do
    @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
    @user2 = FactoryGirl.create(:user, email: "jdoe2@email.com", first_name: "Jim")
    @user3 = FactoryGirl.create(:user, email: "jdoe3@email.com", first_name: "Jima")
    @user4 = FactoryGirl.create(:user, email: "jdoe4@email.com", first_name: "Jimb")
    @user5 = FactoryGirl.create(:user, email: "jdoe5@email.com", first_name: "Jimc")
    @user6 = FactoryGirl.create(:user, email: "jdoe6@email.com", first_name: "Jimd")
    @user7 = FactoryGirl.create(:user, email: "jdoe7@email.com", first_name: "Jime")
    @user8 = FactoryGirl.create(:user, email: "jdoe8@email.com", first_name: "Jimf")
    @user9 = FactoryGirl.create(:user, email: "jdoe9@email.com", first_name: "Jimg")
    @user10 = FactoryGirl.create(:user, email: "jdoe10@email.com", first_name: "Jimh")
    @user11 = FactoryGirl.create(:user, email: "jdoe11@email.com", first_name: "Jimi")
    sign_in_user(@user1)
    visit "/users"
  end
  context "layout" do
    it "should have an all users header" do
      page.should have_content('All users')
    end
    it "should have only the first ten users" do
      page.has_css?("li.user_profile_info", :count => 10)
    end
    it "should have pagination" do
      page.has_css?("div.pagination")
    end
  end
end