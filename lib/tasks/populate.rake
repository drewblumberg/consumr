namespace :db do
  desc "add fake users to dev environment"
  task :populate => :environment do
    require 'faker'

    # create 50 test users
    50.times do |u|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email
      password = "password"

      test_user = User.create!(
        :first_name => first_name,
        :last_name => last_name,
        :email => email,
        :password => password)
    end
  end
end