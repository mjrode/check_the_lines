require 'test_helper'

describe 'Games::CreateGameRecord' do
  def setup
    VCR.use_cassette("action_data_cfb_historical") do
      Fetch::Action.run(sport: "ncaaf", week: "1")
    end

    VCR.use_cassette("massey_cf") do
      Fetch::Massey.run(sport: "ncaaf", date: '2019/08/31')
    end
  end

  describe 'CFB historical data' do
    it 'creates game records by combining action games and massey games' do
      Games::CreateGameRecord.run(process_all_games: true)
      game = Game.where(external_id: 68576).first
      assert_equal game.id, 61
      assert_equal game.sport, "ncaaf"
      assert_equal game.home_team_name, "Duke Blue Devils"
      assert_equal game.away_team_name, "Alabama Crimson Tide"
      assert_equal game.date.to_s, '2019-08-31'
      assert_equal game.home_team_massey_line, 21.5
      assert_equal game.away_team_massey_line, -21.5
      assert_equal game.home_team_vegas_line, 34.5
      assert_equal game.away_team_vegas_line, -34.5
      assert_equal game.vegas_over_under, 57.5
      assert_equal game.processed, false
      assert_equal game.massey_over_under, 59.5
      assert_equal game.home_team_final_score, 3
      assert_equal game.away_team_final_score, 42
      assert_equal game.home_team_money_percent, "61"
      assert_equal game.away_team_money_percent, "39"
      assert_equal game.home_team_spread_percent, "22"
      assert_equal game.away_team_spread_percent, "78"
      assert_equal game.over_percent, "83"
      assert_equal game.under_percent, "17"
      assert_equal game.game_over, true
      assert_equal game.time, "Final"
      assert_equal game.home_contrarian, 0.0
      assert_equal game.away_contrarian, 70.0
      assert_equal game.home_steam, 0.0
      assert_equal game.away_steam, 3.0
      assert_equal game.home_overall_rating, 0.0
      assert_equal game.away_overall_rating, 70.0
      assert_equal game.home_rlm, 0.0
      assert_equal game.away_rlm, 5.0
      assert_equal game.home_team_logo, "https://static.sprtactn.co/teamlogos/ncaaf/100/dukd.png"
      assert_equal game.away_team_logo, "https://static.sprtactn.co/teamlogos/ncaaf/100/bama.png"
      assert_equal game.home_team_abbr, "DUKE"
      assert_equal game.away_team_abbr, "BAMA"
      assert_equal game.external_id, 68576
    end
  end
end