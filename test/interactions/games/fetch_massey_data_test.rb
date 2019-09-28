require 'test_helper'


class Fetch::MasseyTest < ActiveSupport::TestCase
  def setup
  end

  test 'Fetches and stores MLB data from Massey' do
   VCR.use_cassette("massey_mlb") do
     Fetch::Massey.run(sport: "mlb", date: "2017/06/25")
   end

   game = MasseyGame.where(away_team_name: "Brewers").first
   assert game.home_team_massey_line == 0.5
   assert game.away_team_massey_line == -0.5
   assert game.home_team_vegas_line == -125
   assert game.away_team_vegas_line == 125
   assert game.game_date.to_s == "2017-06-25"
   assert game.home_team_final_score == 0
   assert game.away_team_final_score == 7

   game2 = MasseyGame.where(home_team_name: "Giants").first
   assert game2.home_team_massey_line == 0.5
   assert game2.away_team_massey_line == -0.5
   assert game2.home_team_vegas_line == -155
   assert game2.away_team_vegas_line == 155
   assert game2.game_date.to_s == "2017-06-25"
 end

  test 'Fetches and stores MLB data from current day Massey' do
    VCR.use_cassette("massey_current_mlb") do
      Fetch::Massey.run(sport: "mlb", date: "2017/06/28")
    end

   game = MasseyGame.where(away_team_name: "Dodgers").first
   assert game.home_team_massey_line == 0.5
   assert game.away_team_massey_line == -0.5
   assert game.home_team_vegas_line == 122.0
   assert game.away_team_vegas_line == -122.0
   assert game.game_date.to_s == "2017-06-28"
   assert game.game_over == false
   assert game.home_team_final_score == nil
   assert game.away_team_final_score == nil

   game2 = MasseyGame.where(away_team_name: "Mets").first
   assert game2.home_team_massey_line == -0.5
   assert game2.away_team_massey_line == 0.5
   assert game2.home_team_vegas_line == -119
   assert game2.away_team_vegas_line == 119
   assert game2.game_date.to_s == "2017-06-28"
   assert game2.game_over == true
   assert game2.home_team_final_score == 0
   assert game2.away_team_final_score == 8

  end

  test "Fetches and sotes NBA data from Massey" do
    VCR.use_cassette("massey_nba") do
      Fetch::Massey.run(sport: "nba", date: "2017/04/11")
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
      Fetch::Massey.run(sport: "cf", date: "2016/12/20")
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
      Fetch::Massey.run(sport: "nfl", date: "2016/11/06")
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

  test "Fetches and stores College Basketball data from Massey" do
    VCR.use_cassette("massey_cb") do
      Fetch::Massey.run(sport: "cb", date: "2017/03/15")
    end

    game = MasseyGame.where(home_team_name: "Rice").first
    assert game.home_team_massey_line == 2.5
    assert game.away_team_massey_line == -2.5
    assert game.home_team_vegas_line == -1.5
    assert game.away_team_vegas_line == 1.5
    assert game.game_date.to_s == "2017-03-15"
    assert game.game_over == true
    assert game.home_team_final_score == 85
    assert game.away_team_final_score == 76

    game2 = MasseyGame.where(home_team_name: "UCF").first
    assert game2.home_team_massey_line == -4.5
    assert game2.away_team_massey_line == 4.5
    assert game2.home_team_vegas_line == -3.0
    assert game2.away_team_vegas_line == 3.0
    assert game2.game_date.to_s == "2017-03-15"
    assert game2.game_over == true
    assert game2.home_team_final_score == 79
    assert game2.away_team_final_score == 74
  end





  test "Skips Massey data where there are no games" do
    VCR.use_cassette("invalid_massey_cf") do
      Fetch::Massey.run(sport: "cf", date: "2016/11/13")
    end
    assert MasseyGame.count == 0
  end

   test "Skip invalid massey data" do
     VCR.use_cassette("invalid_massey_nfl") do
       Fetch::Massey.run(sport: "nfl", date: "2015/12/13")
     end
     assert MasseyGame.count == 0
   end
end
