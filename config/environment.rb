# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Consumr::Application.initialize!

# Capybara selenium driver set to Chrome
if rails.env == "test"
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
end
