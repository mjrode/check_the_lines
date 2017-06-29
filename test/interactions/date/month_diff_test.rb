# require 'test_helper'
#
# class Date::MonthDiffTest < ActiveSupport::TestCase
#   test 'When current month is November and sportsbook month is August return 3' do
#     month_diff = Date::MonthDiff.run(date: "2016-08-01")
#     assert month_diff == 3
#   end
#
#   test 'When current month is November and sportsbook month is November return 0' do
#     month_diff = Date::MonthDiff.run(date: "2016-11-25")
#     assert month_diff.zero?
#   end
#
#   test 'when current month is November 2016 and sportsbook date is January 2017' do
#     month_diff = Date::MonthDiff.run(date: "2017-01-08")
#     assert month_diff == 2
#   end
# end
