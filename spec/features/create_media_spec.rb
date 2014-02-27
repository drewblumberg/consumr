require 'spec_helper'

describe "Create Media" do
  context "book search" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in_user(@user)
      visit '/'
      click_button('Add Media')
      select('Book', :from => 'categories_search')
    end
    it "should have a search input" do
      page.should have_css('input[id="search_item"]')
    end
    it "should have search button" do
      find_button('Search').visible?
    end
    it "should display the list of books" do
      pending "Needs to be mocked"
    end
  end
end