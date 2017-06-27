# require 'test_helper'
#
# class Games::FetchPublicPercentageTest < ActiveSupport::TestCase
#   test 'Fetches NCAAB data from MasseyRatings for current month' do
# 		use_cassette("public_betting_ncaaf") do
# 		  Games::FetchMasseyData.run(url: "http://www.masseyratings.com/cf/11604/games?dt=20160917", sport: "ncaa_football", sportsbook_month: "September", date: "17")
# #		  Games::FetchPublicPercentage.run(date: "17", sport: "ncaa_basketball", sportsbook_month: "september")
# #			game = Game.find_by_home_team_name("Northwestern")
# #
# #			assert game.week_id == 20160917
# #			puts game.home_team_vegas_line
# #			assert game.home_team_vegas_line == -4
# 		end
#   end
#
# end
