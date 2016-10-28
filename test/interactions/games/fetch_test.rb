require 'test_helper'

class Games::FetchTest < ActiveSupport::TestCase
  test 'it gets called' do
    Games::Fetch.run
    pass
  end
end
