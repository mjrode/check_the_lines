require 'test_helper'


class Games::FetchMasseyDataTest < ActiveSupport::TestCase
  def setup
  end

 test 'Fetches and stores MLB data from Massey' do
  VCR.use_cassette("massey_mlb") do
    Games::FetchMasseyData.run(sport: "mlb", date: "2017/06/25")
  end

   game = MasseyGame.where(away_team_name: "Brewers").first
   assert game.home_team_massey_line == 0.5
   assert game.away_team_massey_line == -0.5
   assert game.home_team_vegas_line == -125
   assert game.away_team_vegas_line == 125
   assert game.game_date.to_s == "2017-06-25"

   game2 = MasseyGame.where(home_team_name: "Giants").first
   assert game2.home_team_massey_line == 0.5
   assert game2.away_team_massey_line == -0.5
   assert game2.home_team_vegas_line == -155
   assert game2.away_team_vegas_line == 155
   assert game2.game_date.to_s == "2017-06-25"
 end

 test "Fetches and sotes NBA data from Massey" do
   VCR.use_cassette("massey_nba") do
     Games::FetchMasseyData.run(sport: "nba", date: "2017/04/11")
   end

   game = MasseyGame.where(away_team_name: "Charlotte").first
   assert game.home_team_massey_line == -2.5
   assert game.away_team_massey_line == 2.5
   assert game.home_team_vegas_line == -8.5
   assert game.away_team_vegas_line == 8.5
   assert game.game_date.to_s == "2017-04-11"

 end

 test "Fetches and stores CF data from Massey" do
   VCR.use_cassette("massey_cf") do
     Games::FetchMasseyData.run(sport: "cf", date: "2016/12/20")
   end

   game = MasseyGame.where(away_team_name: "Navy").first
   assert game.home_team_massey_line == 2.5
   assert game.away_team_massey_line == -2.5
   assert game.home_team_vegas_line == -8.0
   assert game.away_team_vegas_line == 8.0
   assert game.game_date.to_s == "2016-12-23"
 end

 test "Fetches and stores NFL data from Massey" do
   VCR.use_cassette("massey_nfl") do
     Games::FetchMasseyData.run(sport: "nfl", date: "2016/11/06")
   end

   game = MasseyGame.where(home_team_name: "NY Giants").first
   assert game.home_team_massey_line == 2.5
   assert game.away_team_massey_line == -2.5
   assert game.home_team_vegas_line == -3.0
   assert game.away_team_vegas_line == 3.0
   assert game.game_date.to_s == "2016-11-06"

   game = MasseyGame.where(home_team_name: "Tampa Bay").first
   assert game.home_team_massey_line == 3.5
   assert game.away_team_massey_line == -3.5
   assert game.home_team_vegas_line == 3.5
   assert game.away_team_vegas_line == -3.5
   assert game.game_date.to_s == "2016-11-03"
 end

 test "Skips and invalid Massey data" do
   VCR.use_cassette("invalid_massey_cf") do
     Games::FetchMasseyData.run(sport: "cf", date: "2016/11/13")
   end
   assert Game.count == 0
 end
end
