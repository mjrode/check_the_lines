require 'test_helper'
describe 'Games::CreateGameRecord' do
  include ActiveSupport::Testing::TimeHelpers

  def setup
    Game.destroy_all
    ActionGame.destroy_all
    MasseyGame.destroy_all
  end

  describe 'CFB historical data' do
    before do
      VCR.use_cassette("action_data_cfb_historical") do
        Fetch::Action.run(sport: "ncaaf", week: "1")
      end

      VCR.use_cassette("massey_cf") do
        Fetch::Massey.run(sport: "ncaaf", date: '2019/08/31')
      end
    end

    it 'creates game records by combining action games and massey games' do
      travel_to Time.new(2019, 10, 24, 01, 04, 44)
      Games::CreateGameRecord.run(process_all_games: true)
      game = Game.where(external_id: 68576).first
      assert_equal game.sport, "ncaaf"
      assert_equal game.home_team_name, "Duke Blue Devils"
      assert_equal game.away_team_name, "Alabama Crimson Tide"
      assert_equal game.date.to_s, '2019-08-31 19:30:00 UTC'
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

  describe 'NFL current data' do

    it 'creates game records by combining action games and massey games' do

      VCR.use_cassette("massey_nfl") do
        Fetch::Massey.run(sport: "nfl", date: '2019/09/30')
      end

      VCR.use_cassette("action_data_nfl") do
        Fetch::Action.run(sport: "nfl")
      end

      Games::CreateGameRecord.run(process_all_games: true)
      game = Game.where(external_id: 68006).first
      assert_equal game.sport, "nfl"
      assert_equal game.home_team_name, "Pittsburgh Steelers"
      assert_equal game.away_team_name, "Cincinnati Bengals"
      assert_equal game.date.to_s, '2019-10-01 00:15:00 UTC'
      assert_equal game.home_team_massey_line, -6.5
      assert_equal game.away_team_massey_line, 6.5
      assert_equal game.home_team_vegas_line, -3.5
      assert_equal game.away_team_vegas_line, 3.5
      assert_equal game.vegas_over_under, 45.0
      assert_equal game.processed, false
      assert_equal game.massey_over_under, 48.5
      assert_equal game.home_team_money_percent, "48"
      assert_equal game.away_team_money_percent, "52"
      assert_equal game.home_team_spread_percent, "54"
      assert_equal game.away_team_spread_percent, "46"
      assert_equal game.over_percent, "54"
      assert_equal game.under_percent, "46"
      assert_equal game.game_over, true
      assert_equal game.time, "07:15 PM"
      assert_equal game.home_contrarian, 0.0
      assert_equal game.away_contrarian, 0.0
      assert_equal game.home_steam, 2.0
      assert_equal game.away_steam, 0.0
      assert_equal game.home_overall_rating, 2.0
      assert_equal game.away_overall_rating, 0.0
      assert_equal game.home_rlm, 0.0
      assert_equal game.away_rlm, 0.0
      assert_equal game.home_team_logo, "https://static.sprtactn.co/teamlogos/nfl/100/pit.png"
      assert_equal game.away_team_logo, "https://static.sprtactn.co/teamlogos/nfl/100/cin.png"
      assert_equal game.home_team_abbr, "PIT"
      assert_equal game.away_team_abbr, "CIN"
      assert_equal game.external_id, 68006
    end

    it 'updates exisiting game records ' do
      VCR.use_cassette("massey_nfl") do
        Fetch::Massey.run(sport: "nfl", date: '2019/09/30')
      end

      VCR.use_cassette("action_data_nfl") do
        Fetch::Action.run(sport: "nfl")
      end

      travel_to Time.new(2020, 11, 24, 01, 04, 44)
      Games::CreateGameRecord.run(process_all_games: true)
      game = Game.where(external_id: 68006).first
      assert_equal game.updated_at, 'Tue, 24 Nov 2020 07:04:44 UTC +00:00'
      assert_equal game.home_team_money_percent, "48"

      VCR.use_cassette("massey_nfl") do
        Fetch::Massey.run(sport: "nfl", date: '2019/09/30')
      end

      VCR.use_cassette("action_data_nfl_updated") do
        Fetch::Action.run(sport: "nfl")
      end


      travel_to Time.new(2020, 11, 25, 01, 04, 44)
      Games::CreateGameRecord.run(process_all_games: true)
      game = Game.where(external_id: 68006).first
      assert_equal game.sport, "nfl"
      assert_equal game.home_team_name, "Pittsburgh Steelers"
      assert_equal game.away_team_name, "Cincinnati Bengals"
      assert_equal game.date.to_s, '2019-10-01 00:15:00 UTC'
      assert_equal game.home_team_massey_line, -6.5
      assert_equal game.away_team_massey_line, 6.5
      assert_equal game.home_team_vegas_line, -3.5
      assert_equal game.away_team_vegas_line, 3.5
      assert_equal game.vegas_over_under, 45.0
      assert_equal game.processed, false
      assert_equal game.massey_over_under, 48.5
      assert_equal game.home_team_money_percent, "99"
      assert_equal game.away_team_money_percent, "52"
      assert_equal game.home_team_spread_percent, "54"
      assert_equal game.away_team_spread_percent, "46"
      assert_equal game.over_percent, "54"
      assert_equal game.under_percent, "46"
      assert_equal game.game_over, true
      assert_equal game.time, "07:15 PM"
      assert_equal game.home_contrarian, 0.0
      assert_equal game.away_contrarian, 0.0
      assert_equal game.home_steam, 2.0
      assert_equal game.away_steam, 0.0
      assert_equal game.home_overall_rating, 2.0
      assert_equal game.away_overall_rating, 0.0
      assert_equal game.home_rlm, 0.0
      assert_equal game.away_rlm, 0.0
      assert_equal game.home_team_logo, "https://static.sprtactn.co/teamlogos/nfl/100/pit.png"
      assert_equal game.away_team_logo, "https://static.sprtactn.co/teamlogos/nfl/100/cin.png"
      assert_equal game.home_team_abbr, "PIT"
      assert_equal game.away_team_abbr, "CIN"
      assert_equal game.external_id, 68006
    end
  end
end