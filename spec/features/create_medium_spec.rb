require 'spec_helper'

describe "Create Media" do
  before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in_user(@user)
      visit '/'
      click_button('Add Media')
      select('Book', :from => 'search_category')
  end
  context "book search" do
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
  context "creating a book" do
    it "should give a success message if saved to db" do
      fill_in("medium[title]", :with => "Harry Potter")
      select("Current", :from => "medium_status")
      select("Book", :from => "medium_category")
      fill_in("Author/Director", :with => "J.K.Rowling")
      fill_in("Image url", :with => "http://bks5.books.google.com/books?id=_oaAHiFOZmgC&printsec=frontcover&img=1&zoom=1&source=gbs_api")
      fill_in("Thoughts", :with => "This book is cool.")
      click_button("Create Media")
      page.should have_content("Your media has been created!")
    end
  end
end