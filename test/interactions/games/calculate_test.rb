require 'test_helper'
# BEST_BET_STRENGTH = 10
# PUBLIC_PERCENTAGE_STRENGTH = 0
# LINE_STRENGTH = 0
# RLM_STRENGTH = 3
# STEAM_STRENGTH = 3
# OVERALL_RATING_STRENGTH = 1
# CONTRARIAN_STRENGTH = 1

describe 'Games::Calculate' do
  include ActiveSupport::Testing::TimeHelpers

  def setup
    Game.destroy_all
    ActionGame.destroy_all
    MasseyGame.destroy_all
  end

  describe 'Historical Games' do
    before do
      VCR.use_cassette('action_data_cfb_historical') do
        Fetch::Action.run(sport: 'ncaaf', week: '1')
      end

      VCR.use_cassette('massey_cf') do
        Fetch::Massey.run(sport: 'ncaaf', date: '2019/08/31')
      end
      Games::CreateGameRecord.run(process_all_games: true)
    end

    it 'calculates and updates game record' do
      Games::CalculateAll.run(process_all_games: true)

      game = Game.where(external_id: 68_576).first
      assert_equal game.sport, 'ncaaf'
      assert_equal game.home_team_name, 'Duke Blue Devils'
      assert_equal game.away_team_name, 'Alabama Crimson Tide'
      assert_equal game.date,
                   DateTime.parse('Sat, 31 Aug 2019 19:30:00 UTC +00:00')
      assert_equal game.home_team_massey_line, 21.5
      assert_equal game.away_team_massey_line, -21.5
      assert_equal game.home_team_vegas_line, 34.5
      assert_equal game.away_team_vegas_line, -34.5
      assert_equal game.vegas_over_under, 57.5
      assert_equal game.best_bet, false
      assert_equal game.massey_over_under, 59.5
      assert_equal game.home_team_line_diff, -13.0
      assert_equal game.away_team_line_diff, 13.0
      assert_equal game.over_under_diff, 2.0
      assert_equal game.team_to_bet, 'Duke Blue Devils'
      assert_equal game.over_under_pick, 'Over'
      assert_equal game.home_team_final_score, 3
      assert_equal game.away_team_final_score, 42
      assert_equal game.home_team_money_percent, '61'
      assert_equal game.away_team_money_percent, '39'
      assert_equal game.home_team_spread_percent, '22'
      assert_equal game.away_team_spread_percent, '78'
      assert_equal game.over_percent, '83'
      assert_equal game.under_percent, '17'
      assert_equal game.public_percentage_on_massey_team, 22
      assert_equal game.game_over, true
      assert_equal game.correct_prediction, false
      assert_equal game.correct_over_under_prediction, false
      assert_equal game.public_percentage_massey_over_under, 83
      assert_equal game.home_team_strength, 50.0
      assert_equal game.away_team_strength, 21.0
      assert_equal game.time, '02:30 PM'
      assert_equal game.home_contrarian, 0.0
      assert_equal game.away_contrarian, 70.0
      assert_equal game.home_steam, 0.0
      assert_equal game.away_steam, 3.0
      assert_equal game.home_overall_rating, 0.0
      assert_equal game.away_overall_rating, 70.0
      assert_equal game.home_rlm, 0.0
      assert_equal game.away_rlm, 5.0
      assert_equal game.home_team_logo,
                   'https://static.sprtactn.co/teamlogos/ncaaf/100/dukd.png'
      assert_equal game.away_team_logo,
                   'https://static.sprtactn.co/teamlogos/ncaaf/100/bama.png'
      assert_equal game.home_team_abbr, 'DUKE'
      assert_equal game.away_team_abbr, 'BAMA'
      assert_equal game.massey_favors_home_or_away, 'home'
      assert_equal game.in_progress, true
      assert_equal game.best_bet_strength, 50.0
      assert_nil game.week
      assert_nil game.ou_best_bet

      game = Game.where(external_id: 68_493).first
      assert_equal game.sport, 'ncaaf'
      assert_equal game.home_team_name, 'BYU Cougars'
      assert_equal game.away_team_name, 'Utah Utes'
      assert_equal game.date,
                   DateTime.parse('Fri, 30 Aug 2019 02:15:00 UTC +00:00')
      assert_equal game.home_team_massey_line, 3.5
      assert_equal game.away_team_massey_line, -3.5
      assert_equal game.home_team_vegas_line, 5.5
      assert_equal game.away_team_vegas_line, -5.5
      assert_equal game.vegas_over_under, 49.0
      assert_equal game.best_bet, false
      assert_equal game.massey_over_under, 44.5
      assert_equal game.home_team_line_diff, -2.0
      assert_equal game.away_team_line_diff, 2.0
      assert_equal game.over_under_diff, -4.5
      assert_equal game.team_to_bet, 'Utah Utes'
      assert_equal game.over_under_pick, 'Under'
      assert_equal game.home_team_final_score, 12
      assert_equal game.away_team_final_score, 30
      assert_equal game.home_team_money_percent, '31'
      assert_equal game.away_team_money_percent, '69'
      assert_equal game.home_team_spread_percent, '43'
      assert_equal game.away_team_spread_percent, '57'
      assert_equal game.over_percent, '42'
      assert_equal game.under_percent, '58'
      assert_equal game.public_percentage_on_massey_team, 43
      assert_equal game.game_over, true
      assert_equal game.correct_prediction, true
      assert_equal game.correct_over_under_prediction, true
      assert_equal game.public_percentage_massey_over_under, 58
      assert_equal game.home_team_strength, 1.0
      assert_equal game.away_team_strength, 2.0
      assert_equal game.time, '09:15 PM'
      assert_equal game.home_contrarian, 0.0
      assert_equal game.away_contrarian, 0.0
      assert_equal game.home_steam, 0.0
      assert_equal game.away_steam, 0.0
      assert_equal game.home_overall_rating, 70.0
      assert_equal game.away_overall_rating, 0.0
      assert_equal game.home_rlm, 1.0
      assert_equal game.away_rlm, 0.0
      assert_equal game.home_team_logo,
                   'https://static.sprtactn.co/teamlogos/ncaaf/100/byu.png'
      assert_equal game.away_team_logo,
                   'https://static.sprtactn.co/teamlogos/ncaaf/100/uth.png'
      assert_equal game.home_team_abbr, 'BYU'
      assert_equal game.away_team_abbr, 'UTAH'
      assert_equal game.massey_favors_home_or_away, 'home'
      assert_equal game.in_progress, true
      assert_equal game.external_id, 68_493
      assert_equal game.best_bet_strength, 2.0
      assert_nil game.week
      assert_nil game.average_home_predicted_line
      assert_nil game.median_home_predicted_line
      assert_nil game.standard_deviation_of_pred
      assert_nil game.probability_home_wins
      assert_nil game.probability_home_covers
      assert_nil game.start_time
      assert_nil game.ou_best_bet
    end
  end
end
