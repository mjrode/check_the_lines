ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# require 'vcr'
require 'mocha/minitest'
require 'webmock/minitest'
require 'minitest/unit'



VCR.configure do |config|
	config.cassette_library_dir = "test/cassettes"
	config.hook_into :webmock
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...


  def use_cassette(name, &blk)
    VCR.use_cassette(name, record: :new_episodes, &blk)
  end
end
