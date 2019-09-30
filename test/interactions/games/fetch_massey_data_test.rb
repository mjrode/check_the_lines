require 'test_helper'


describe 'Fetch::Massey' do
  def setup
  end

  describe "Fetching CFB data" do
    it "fetches and stores historical data" do
      VCR.use_cassette("massey_cf") do
        Fetch::Massey.run(sport: "ncaaf", date: '2019/08/31')
      end

      game = MasseyGame.where(away_team_name: "Alabama Crimson Tide").first
      assert_equal game.home_team_massey_line, 21.5
      assert_equal game.away_team_massey_line, -21.5
      assert_equal game.away_team_name, "Alabama Crimson Tide"
      assert_equal game.home_team_name, "Duke Blue Devils"
      assert_equal game.massey_over_under, 59.5
      assert_equal game.home_team_vegas_line, 33.5
      assert_equal game.away_team_vegas_line, -33.5
      assert_equal game.home_team_final_score, 3.0
      assert_equal game.away_team_final_score, 42.0
      assert_equal game.game_date.to_s, '2019-08-31'
      assert_equal game.external_id, 930073771
      assert_equal game.sport, "ncaaf"
      assert_equal game.game_over, true
      assert_equal game.time, 'Final'
    end
  end


  describe "Fetching NFL data" do
    it "fetches and stores current data" do
      VCR.use_cassette("massey_nfl") do
        Fetch::Massey.run(sport: "nfl", date: '2019/09/30')
      end

      game = MasseyGame.where(external_id: 930336208).first
      assert_equal game.home_team_massey_line, -6.5
      assert_equal game.away_team_massey_line, 6.5
      assert_equal game.away_team_name, "Cincinnati Bengals"
      assert_equal game.home_team_name, "Pittsburgh Steelers"
      assert_equal game.massey_over_under, 48.5
      assert_equal game.home_team_vegas_line, -3.5
      assert_equal game.away_team_vegas_line, 3.5
      assert_equal game.game_date.to_s, '2019-09-30'
      assert_equal game.external_id, 930336208
      assert_equal game.sport, "nfl"
      assert_equal game.processed, false
      assert_equal game.game_over, false
      assert_equal game.time, "08:15.PM.ET"
    end
  end

  it "Skips Massey data where there are no games" do
    MasseyGame.destroy_all
    VCR.use_cassette("invalid_massey_cf") do
      Fetch::Massey.run(sport: "ncaaf", date: "2016/11/13")
    end
    assert MasseyGame.count == 0
  end

   it "Skip invalid massey data" do
     MasseyGame.destroy_all
     VCR.use_cassette("invalid_massey_nfl") do
       Fetch::Massey.run(sport: "nfl", date: "2015/12/13")
     end
     assert MasseyGame.count == 0
   end
end
