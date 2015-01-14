require 'simplecov'
SimpleCov.start 'rails'

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

begin
  require File.expand_path('../dummy/config/environment.rb',  __FILE__)
rescue LoadError
  puts 'Could not load dummy application. Run `bundle exec rake test_app` first'
  exit
end

require 'rspec/rails'
require 'shoulda-matchers'
require 'ffaker'
require 'database_cleaner'
require 'capybara'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

# Testing support from spree_core
require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/flash'
require 'spree/testing_support/capybara_ext'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Configure poltergeist for javascript testing
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { js_errors: false })
end
Capybara.javascript_driver = :poltergeist

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.deprecation_stream = 'rspec.log'
  config.include Spree::TestingSupport::ControllerRequests
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::Flash
  config.include Devise::TestHelpers, type: :controller
  config.use_transactional_fixtures = false
  config.expose_current_running_example_as :example
  config.infer_spec_type_from_file_location!

  # Ensure Suite is set to use transactions for speed.
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  # Before each spec check if it is a Javascript test and switch between 
  # using database transactions or not where necessary.
  config.before :each do
    strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.strategy = strategy
    DatabaseCleaner.start
  end

  # After each spec clean the database.
  config.after :each do
    DatabaseCleaner.clean
  end

  config.fail_fast = ENV['FAIL_FAST'] || false
end
