require 'test_helper'

class Date::MonthDiffTest < ActiveSupport::TestCase
  test 'When current month is November and sportsbook month is August return 3' do
    month_diff = Date::MonthDiff.run(month: "August")
    assert month_diff == 3
  end

  test 'When current month is November and sportsbook month is November return 0' do
    month_diff = Date::MonthDiff.run(month: "November")
    assert month_diff == 0
   end

end
