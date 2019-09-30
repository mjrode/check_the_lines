require 'test_helper'


class Fetch::MasseyTest < ActiveSupport::TestCase
  def setup
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
