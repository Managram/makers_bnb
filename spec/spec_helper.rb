ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app/app.rb')

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'database_cleaner'
require 'helpers'
require 'web_helper'
require 'factory_girl'

Capybara.app = MakersBnb

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  # config.include Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    FactoryGirl.lint
  end

  FactoryGirl.define do
    factory :space do
      name          'Humpty Dumpty'
      description   'nice wall'
      price         '19.99'
    end
  end

  FactoryGirl.define do
    factory :request do
      start_date '24/01/2016'
      end_date   '05/04/2016'
      status     1
    end
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
