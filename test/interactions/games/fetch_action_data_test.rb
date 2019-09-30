require 'test_helper'

describe 'Fetch::Action' do
  def setup
  end

  describe 'Fetching CFB data' do
    it 'fetch and store current data' do
    VCR.use_cassette("action_data") do
      Fetch::Action.run(sport: "ncaaf")
      game = ActionGame.where(external_id: 68954).first
      assert game.sport == 'ncaaf'
      assert game.home_team_name == 'Memphis Tigers'
      assert game.away_team_name == 'Navy Midshipmen'
      assert game.under_percent == 40
      assert game.over_percent == 60
      assert game.home_team_ml_percent == 52
      assert game.away_team_ml_percent == 48
      assert game.home_team_ats_percent == 38
      assert game.away_team_ats_percent == 62
      assert game.game_date.to_s == "2019-09-27"
      assert game.home_team_vegas_line == -10.5
      assert game.away_team_vegas_line == 10.5
      assert game.vegas_over_under == 54.5
      assert game.home_team_final_score == 35.0
      assert game.away_team_final_score == 23.0
      assert game.home_steam == 14.0
      assert game.away_steam == 0
      assert game.home_contrarian == 20.0
      assert game.away_contrarian == 0.0
      assert game.home_overall_rating == 34.0
      assert game.away_overall_rating == 0.0
      assert game.away_rlm == nil
      assert game.home_rlm == nil
      assert game.home_team_abbr == 'MEM'
      assert game.away_team_abbr == 'NAVY'
      assert game.week == '5'
      assert game.game_over == true
    end
  end
end
end