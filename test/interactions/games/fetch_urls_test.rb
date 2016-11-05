require 'test_helper'

class Games::FetchUrlsTest < ActiveSupport::TestCase
  test 'it gets called' do
    Games::FetchUrls.run
    pass
  end
end
