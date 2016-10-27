require 'test_helper'

class Games::CalculateTest < ActiveSupport::TestCase
  test 'it gets called' do
    Games::Calculate.run
    pass
  end
end
