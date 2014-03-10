require 'spec_helper'

describe "All Media Page" do
  before do
    @user = FactoryGirl.create(:user, email: "drew@example.com")
    @current = FactoryGirl.create(:medium, user: @user)
    @wish_list = FactoryGirl.create(:medium, user: @user, status: "Wish List", title: "Pokemon", category: "TV Show")
    @finished = FactoryGirl.create(:medium, user: @user, status: "Finished", title: "War and Peace", category: "Book")
    sign_in_user(@user)
    visit '/media'
  end
  context "layout" do
    it "should have the All Media header" do
      page.should have_content('All Media')
    end
    it "should have headers for each status" do
      page.should have_content('Current Media')
      page.should have_content('Wish List')
      page.should have_content('Finished')
    end
    it "should have the three media items listed" do
      page.should have_content('Harry Potter and the Deathly Hallows, Book')
      page.should have_content('Pokemon, TV Show')
      page.should have_content('War and Peace, Book')
    end
    it "should have buttons for editing and deleting" do
      page.has_css?('input[value="Edit"]', count: 3)
      page.has_css?('input[value="Delete"]', count: 3)
    end
  end
  context "deleting media" do
    before do
      within(:css, "li.medium_#{@wish_list.id}") do
        click_button('Delete')
      end
    end
    it "should display a success message when successful" do
      page.should have_content("Your media was successfully removed")
    end
    it "should have only two items left" do
      page.should_not have_content('Pokemon, TV Show')
      page.should have_content('War and Peace, Book')
      page.should have_content('Harry Potter and the Deathly Hallows, Book')
    end
  end
  context "editing media" do
    before do
      within(:css, "li.medium_#{@wish_list.id}") do
        click_button('Edit')
      end
    end
    it "should have an edit media header" do
      page.should have_content('Edit Media')
    end
    it "should display a success message when successful" do
      fill_in("Title", with: "Pokemon Edited")
      click_button("Update")
      page.should have_content("Media was successfully updated")
    end
    it "should have all items" do
      fill_in("Title", with: "Pokemon Edited")
      select("Book", :from => "medium_category")
      click_button("Update")
      page.should have_content('Pokemon Edited, Book')
      page.should have_content('War and Peace, Book')
      page.should have_content('Harry Potter and the Deathly Hallows, Book')
    end
  end
end