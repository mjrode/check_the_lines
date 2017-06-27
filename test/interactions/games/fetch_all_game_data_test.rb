# require 'test_helper'
#
# class Games::FetchAllGameDataTest < ActiveSupport::TestCase
#   test 'fetches ncaaf data for past month' do
# 		use_cassette("fetch_all_game_data_past_month_football") do
# 		  Games::FetchAllGameData.run(url: "http://www.masseyratings.com/cf/11604/games?dt=20160917", sport: "ncaa_football", sportsbook_month: "September", date: "17")
#
# 			game = Game.find_by_home_team_name("Northwestern")
#
# 			assert game.week_id == 20160917
# 			assert game.home_team_massey_line == -6.5
# 			assert game.away_team_massey_line == 6.5
# 			assert game.home_team_vegas_line == -4
# 			assert game.away_team_vegas_line == 4
# 			assert game.home_team_spread_percent == "55"
# 			assert game.away_team_spread_percent == "45"
# 			assert game.over_percent == "43"
# 			assert game.under_percent == "57"
# 		end
#   end
#
#   test 'fetches ncaab data for current month' do
# 		use_cassette("fetch_all_game_data_past_month_ncaab") do
# 		  Games::FetchAllGameData.run(url: "http://www.masseyratings.com/cb/11590/games?dt=20161123", sport: "ncaa_basketball", sportsbook_month: "November", date: "23")
#
# 			game = Game.find_by_home_team_name("Rutgers")
#
# 			assert game.week_id == 20161123
# 			assert game.home_team_massey_line == -10.5
# 			assert game.away_team_massey_line == 10.5
# 			assert game.home_team_vegas_line == -16.0
# 			assert game.away_team_vegas_line == 16.0
# 			assert game.home_team_spread_percent == "82"
# 			assert game.away_team_spread_percent == "18"
# 			assert game.over_percent == "53"
# 			assert game.under_percent == "47"
#
# 			assert game.game_over == true
# 			assert game.team_to_bet == "North Texas"
# 			assert game.over_under_pick == "Over"
# 			assert game.correct_prediction == false
# 		end
# 	end
# end
