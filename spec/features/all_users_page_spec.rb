require 'spec_helper'

describe "All Users Page" do
  before do
    9.times do
      FactoryGirl.create(:user, email: Faker::Internet.email, first_name: Faker::Name.first_name)
    end
    @user1 = FactoryGirl.create(:user, email: "alblumberg21@gmail.com")
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
  context "links" do
    it "should go to correct user page if you click a link" do
      find(:css, "a[href='/users/#{@user1.id}']").click
      page.should have_content('Jon Snow')
    end
  end
end