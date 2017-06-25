require 'test_helper'


class Games::FetchMasseyDataTest < ActiveSupport::TestCase
  def setup
  end

 test 'Fetches and stores MLB data from Massey' do
  VCR.use_cassette("massey_mlb") do
    Games::FetchMasseyData.run(sport: "mlb", date: "2017/06/25")
  end

   game = Game.where(away_team_name: "Brewers").first
   assert game.home_team_massey_line == 0.5
   assert game.away_team_massey_line == -0.5
   assert game.home_team_vegas_line_massey == -125
   assert game.away_team_vegas_line_massey == 125
   assert game.date.to_s == "2017-06-25"

   game2 = Game.where(home_team_name: "Giants").first
   assert game2.home_team_massey_line == 0.5
   assert game2.away_team_massey_line == -0.5
   assert game2.home_team_vegas_line_massey == -155
   assert game2.away_team_vegas_line_massey == 155
   assert game2.date.to_s == "2017-06-25"
 end

 test "Fetches and sotes NBA data from Massey" do
   VCR.use_cassette("massey_nba") do
     Games::FetchMasseyData.run(sport: "nba", date: "2017/04/11")
   end

   game = Game.where(away_team_name: "Charlotte").first
   assert game.home_team_massey_line == -2.5
   assert game.away_team_massey_line == 2.5
   assert game.home_team_vegas_line_massey == -8.5
   assert game.away_team_vegas_line_massey == 8.5
   assert game.date.to_s == "2017-04-11"

 end

 test "Fetches and sotes CF data from Massey" do
   VCR.use_cassette("massey_cf") do
     Games::FetchMasseyData.run(sport: "cf", date: "2016/12/20")
   end

   game = Game.where(away_team_name: "Navy").first
   assert game.home_team_massey_line == 2.5
   assert game.away_team_massey_line == -2.5
   assert game.home_team_vegas_line_massey == -8.0
   assert game.away_team_vegas_line_massey == 8.0
   assert game.date.to_s == "2016-12-20"
 end

#  test 'fetchs NCAAF data from MasseyRatings for previous month' do
# 		VCR.use_cassette("ncaam_football_past_month") do
# 		  Games::FetchMasseyData.run(url: "http://www.masseyratings.com/cf/11604/games?dt=20160917", sport: "ncaa_football", sportsbook_month: "September", date: "17")
# 			game = Game.find_by_home_team_name("Rice")
#
# 			assert game.away_team_name == "Baylor"
# 			assert game.home_team_massey_line == 26.5
# 			assert game.away_team_massey_line == -26.5
# 			assert game.week_id == 20160917
# 		end
#  end
end
