require 'test_helper'

describe 'Fetch::Action' do
  describe 'Fetching CFB data' do
    it 'fetches and stores current data' do
      VCR.use_cassette("action_data_cfb") do
        Fetch::Action.run(sport: "ncaaf")
        game = ActionGame.where(external_id: 68954).first
        assert_equal game.sport, 'ncaaf'
        assert_equal game.home_team_name, 'Memphis Tigers'
        assert_equal game.away_team_name, 'Navy Midshipmen'
        assert_equal game.under_percent, 40
        assert_equal game.over_percent, 60
        assert_equal game.home_team_ml_percent, 52
        assert_equal game.away_team_ml_percent, 48
        assert_equal game.home_team_ats_percent, 38
        assert_equal game.away_team_ats_percent, 62
        assert_equal game.game_date.to_s, "2019-09-27"
        assert_equal game.home_team_vegas_line, -10.5
        assert_equal game.away_team_vegas_line, 10.5
        assert_equal game.vegas_over_under, 54.5
        assert_equal game.home_team_final_score, 35.0
        assert_equal game.away_team_final_score, 23.0
        assert_equal game.home_steam, 14.0
        assert_equal game.away_steam, 0
        assert_equal game.home_contrarian, 20.0
        assert_equal game.away_contrarian, 0.0
        assert_equal game.home_overall_rating, 34.0
        assert_equal game.away_overall_rating, 0.0
        assert_equal game.away_rlm, 0
        assert_equal game.home_rlm, 0
        assert_equal game.home_team_abbr, 'MEM'
        assert_equal game.away_team_abbr, 'NAVY'
        assert_equal game.week, '5'
        assert_equal game.game_over, true
      end
    end

    it 'updates action game when passed new data' do
      VCR.use_cassette("action_data_cfb") do
        Fetch::Action.run(sport: "ncaaf")
      end

      game = ActionGame.where(external_id: 68954).first
      assert_equal game.under_percent, 40

      VCR.use_cassette("action_data_cfb_updated") do
        Fetch::Action.run(sport: "ncaaf")
        game = ActionGame.where(external_id: 68954).first
        assert_equal game.sport, 'ncaaf'
        assert_equal game.home_team_name, 'Memphis Tigers'
        assert_equal game.away_team_name, 'Navy Midshipmen'
        assert_equal game.under_percent, 99
        assert_equal game.over_percent, 60
        assert_equal game.home_team_ml_percent, 52
        assert_equal game.away_team_ml_percent, 48
        assert_equal game.home_team_ats_percent, 38
        assert_equal game.away_team_ats_percent, 62
        assert_equal game.game_date.to_s, "2019-09-27"
        assert_equal game.home_team_vegas_line, -10.5
        assert_equal game.away_team_vegas_line, 10.5
        assert_equal game.vegas_over_under, 54.5
        assert_equal game.home_team_final_score, 35.0
        assert_equal game.away_team_final_score, 23.0
        assert_equal game.home_steam, 14.0
        assert_equal game.away_steam, 0
        assert_equal game.home_contrarian, 20.0
        assert_equal game.away_contrarian, 0.0
        assert_equal game.home_overall_rating, 34.0
        assert_equal game.away_overall_rating, 0.0
        assert_equal game.away_rlm, 0
        assert_equal game.home_rlm, 0
        assert_equal game.home_team_abbr, 'MEM'
        assert_equal game.away_team_abbr, 'NAVY'
        assert_equal game.week, '5'
        assert_equal game.game_over, true
      end
    end

    it 'fetches and stores historical data' do
      VCR.use_cassette("action_data_cfb_historical") do
        Fetch::Action.run(sport: "ncaaf", week: '1')

        game = ActionGame.where(external_id: 68576).first
        assert_equal game.sport, 'ncaaf'
        assert_equal game.start_time, '2019-08-31T19:30:00.000Z'
        assert_equal game.home_team_name, 'Duke Blue Devils'
        assert_equal game.away_team_name, 'Alabama Crimson Tide'
        assert_equal game.under_percent, 17
        assert_equal game.over_percent, 83
        assert_equal game.home_team_ml_percent, 61
        assert_equal game.away_team_ml_percent, 39
        assert_equal game.home_team_ats_percent, 22
        assert_equal game.away_team_ats_percent, 78
        assert_equal game.game_date.to_s, "2019-08-31"
        assert_equal game.home_team_vegas_line, 34.5
        assert_equal game.away_team_vegas_line, -game.home_team_vegas_line
        assert_equal game.vegas_over_under, 57.5
        assert_equal game.home_team_final_score, 3
        assert_equal game.away_team_final_score, 42.0
        assert_equal game.home_steam, 0
        assert_equal game.away_steam, 3.0
        assert_equal game.home_contrarian, 0
        assert_equal game.away_contrarian, 70.0
        assert_equal game.home_overall_rating, 0
        assert_equal game.away_overall_rating, 70.0
        assert_equal game.away_rlm, 5.0
        assert_equal game.home_rlm, 0
        assert_equal game.home_team_abbr, 'DUKE'
        assert_equal game.away_team_abbr, 'BAMA'
        assert_equal game.week, '1'
        assert_equal game.game_over, true
      end
    end
  end

  describe 'Fetching NFL data' do
    it 'fetches and stores current data ' do
      VCR.use_cassette("action_data_nfl") do
        Fetch::Action.run(sport: "nfl")
        game = ActionGame.where(external_id: 68006).first
        assert_equal game.game_date.to_s, '2019-10-01'
        assert_equal game.sport, "nfl"
        assert_equal game.home_team_name, "Pittsburgh Steelers"
        assert_equal game.away_team_name, "Cincinnati Bengals"
        assert_equal game.under_percent, 46
        assert_equal game.over_percent, 54
        assert_equal game.home_team_ml_percent, 48
        assert_equal game.away_team_ml_percent, 52
        assert_equal game.home_team_ats_percent, 54
        assert_equal game.away_team_ats_percent, 46
        assert_equal game.away_team_vegas_line, 3.5
        assert_equal game.home_team_vegas_line, -3.5
        assert_equal game.vegas_over_under, 45.0
        assert_equal game.external_id, 68006
        assert_equal game.processed, false
        assert_equal game.game_over, false
        assert_equal game.num_bets, 33349
        assert_equal game.home_contrarian, 0.0
        assert_equal game.away_contrarian, 0.0
        assert_equal game.away_steam, 0.0
        assert_equal game.home_steam, 2.0
        assert_equal game.home_overall_rating, 2.0
        assert_equal game.away_overall_rating, 0.0
        assert_equal game.home_rlm, 0.0
        assert_equal game.away_rlm, 0.0
        assert_equal game.home_team_logo, "https://static.sprtactn.co/teamlogos/nfl/100/pit.png"
        assert_equal game.away_team_logo, "https://static.sprtactn.co/teamlogos/nfl/100/cin.png"
        assert_equal game.home_team_abbr, "PIT"
        assert_equal game.away_team_abbr, "CIN"
        assert_equal game.start_time, DateTime.parse('Tue, 01 Oct 2019 00:15:00 UTC +00:00')
        assert_equal game.week, "4"
      end
    end
  end
end