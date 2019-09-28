require 'test_helper'

class Fetch::ActionTest < ActiveSupport::TestCase
  def setup
  end

  test 'Fetches and stores MLB data from Action for games played' do
    VCR.use_cassette("action_mlb_played") do
      Fetch::Action.run(sport: "mlb", date: "2017/06/07")
    end

    game = ActionGame.where(away_team_name: "Washington Nationals").first
    assert game.under_percent == 52
    assert game.over_percent == 48
    assert game.home_team_ml_percent == 62
    assert game.away_team_ml_percent == 38
    assert game.home_team_ats_percent == 55
    assert game.away_team_ats_percent == 45
    assert game.game_date.to_s == "2017-06-07"
    assert game.home_team_vegas_line == -1.5
    assert game.away_team_vegas_line == 1.5
    assert game.vegas_over_under == 6.5
    assert game.home_team_final_score == 2
    assert game.away_team_final_score == 1
    assert game.game_over == true

    game2 = ActionGame.where(home_team_name: "Colorado Rockies").first

    assert game2.game_date.to_s == "2017-06-07"
    assert game2.under_percent == 46
    assert game2.over_percent == 54
    assert game2.home_team_ml_percent == 66
    assert game2.away_team_ml_percent == 34
    assert game2.home_team_ats_percent == 60
    assert game2.away_team_ats_percent == 40
    assert game2.home_team_vegas_line == 1.5
    assert game2.away_team_vegas_line == -1.5
    assert game2.home_team_final_score == 8
    assert game2.away_team_final_score == 1
    assert game2.game_over == true
    assert game2.vegas_over_under == 11
  end

  test 'Fetches and stores MLB data from Action for games not played' do
    VCR.use_cassette("action_mlb") do
      Fetch::Action.run(sport: "mlb", date: "2017/07/01")
    end

    game = ActionGame.where(away_team_name: "Chicago Cubs").first
    assert game.under_percent ==  49
    assert game.over_percent ==   51
    assert game.home_team_ml_percent == 31
    assert game.away_team_ml_percent == 69
    assert game.home_team_ats_percent == 33
    assert game.away_team_ats_percent == 67
    assert game.game_date.to_s == "2017-07-01"
    assert game.home_team_vegas_line == 1.5
    assert game.away_team_vegas_line == -1.5
    assert game.vegas_over_under == 11
    assert game.home_team_final_score == 0
    assert game.away_team_final_score == 0

    game2 = ActionGame.where(home_team_name: "Chicago White Sox").first

    assert game2.game_date.to_s == "2017-07-01"
    assert game2.under_percent == 48
    assert game2.over_percent == 52
    assert game2.home_team_ml_percent == 32
    assert game2.away_team_ml_percent == 68
    assert game2.home_team_ats_percent == 34
    assert game2.away_team_ats_percent == 66
    assert game2.home_team_vegas_line == 1.5
    assert game2.away_team_vegas_line == -1.5
    assert game2.vegas_over_under == 10
    assert game.home_team_final_score == 0
    assert game.away_team_final_score == 0
  end
end
