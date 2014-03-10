FactoryGirl.define do
  factory :medium do
    user
    category "Book"
    title "Harry Potter and the Deathly Hallows"
    status "Current"
    image_url "http://bks5.books.google.com/books?id=_oaAHiFOZmgC&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    creator "J.K. Rowling"
    thoughts "This book is really good!"
  end
end