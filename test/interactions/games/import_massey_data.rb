require 'test_helper'

class Games::ImportMasseyData < ActiveSupport::TestCase
  test 'it gets called' do
    Games::Fetch.run
    pass
  end
end
