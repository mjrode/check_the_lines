require 'test_helper'

class Games::LoadAllDataTest < ActiveSupport::TestCase
  test 'it gets called' do
    Games::LoadAllData.run
    pass
  end
end
