class SearchesController < ApplicationController

  def search
    @title = params[:search_item]
    @category = params[:search_category]

    if(@category == '3')
      @media_items = GoogleBooks.search(@title) 
      respond_to do |format|
        format.html
        format.js { render 'searches/search' }
      end
    elsif(@category == '1')
      @media_items = Tmdb::Movie.find(@title)
      respond_to do |format|
        format.html
        format.js { render 'searches/search' }
      end
    elsif(@category == '2')
      @media_items = Tmdb::TV.find(@title)
      respond_to do |format|
        format.html
        format.js { render 'searches/search' }
      end
    else
      flash[:notice] = 'Incorrect search category'
      redirect_to new_medium_path
    end
  end
end