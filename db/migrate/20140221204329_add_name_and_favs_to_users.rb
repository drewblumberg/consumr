class AddNameAndFavsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :fav_movies, :text
    add_column :users, :fav_tv, :text
    add_column :users, :fav_books, :text
  end
end
