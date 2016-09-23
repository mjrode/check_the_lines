require 'test_helper'

class Games::ImportTest < ActiveSupport::TestCase
  test 'it gets called' do
    Games::Import.run
    pass
  end
end
