class SearchesController < ApplicationController

  def book_search
    title = params[:search_item]
    @books = GoogleBooks.search(title) 

    respond_to do |format|
      format.html
      format.js { render 'media/book_search' }
    end
  end
end