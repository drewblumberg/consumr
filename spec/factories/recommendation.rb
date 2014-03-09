FactoryGirl.define do
  factory :recommendation do
    user
    creator_id 1 
    body "default body"
  end
end