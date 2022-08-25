# DB cleaner using database cleaner library
RSpec.configure do |config|
    # This says that before the entire test suite runs, clear 
    # the test database out completely
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end
   
    # This sets the default database cleaning strategy to 
    # be transactions
    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end
   
    # include this if you uses capybara integration tests
    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end
   
    # These lines hook up database_cleaner around the beginning 
    # and end of each test, telling it to execute whatever 
    # cleanup strategy we selected
    config.before(:each) do
      DatabaseCleaner.start
    end
   
    config.after(:each) do
      DatabaseCleaner.clean
    end
  end