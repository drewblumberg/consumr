Consumr
=======

## Summary

Media consumption social network with a library of consumed media and a social recommendation system.

1. Create a repository of books, tv shows, and movies.
2. Add friends and see what media they are currently consuming.
3. Make recommendations on what they should see next.

## Project Setup

1. Clone the repo to your computer
   `git clone https://github.com/drewblumberg/consumr.git`
1. Create the databases
   `rake db:create:all`
1. Run the migrations
   `rake db:migrate`
2. Create an app at [The Movie DB](themoviedb.org) and retrieve an API key
3. Create an 'env_vars.yml' in [config](/config)
4. Start your rails server
   `rails s`