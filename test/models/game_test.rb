# == Schema Information
#
# Table name: games
#
#  id                                  :integer          not null, primary key
#  sport                               :string
#  home_team_name                      :string
#  away_team_name                      :string
#  date                                :date
#  home_team_massey_line               :float
#  away_team_massey_line               :float
#  home_team_vegas_line                :float
#  away_team_vegas_line                :float
#  vegas_over_under                    :float
#  massey_over_under                   :float
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  line_diff                           :float
#  over_under_diff                     :float
#  team_to_bet                         :string
#  over_under_pick                     :string
#  home_team_final_score               :integer
#  away_team_final_score               :integer
#  week_id                             :integer
#  home_team_spread_percent            :string
#  away_team_spread_percent            :string
#  over_percent                        :string
#  under_percent                       :string
#  public_percentage_on_massey_team    :integer
#  game_over                           :boolean
#  correct_prediction                  :boolean
#  correct_over_under_prediction       :boolean
#  public_percentage_massey_over_under :integer
#  strength                            :decimal(, )
#  time                                :string
#  home_team_vegas_line_massey         :float
#  away_team_vegas_line_massey         :float
#  home_team_vegas_line_wunder         :float
#  away_team_vegas_line_wunder         :float
#

require 'test_helper'

#class GameTest < ActiveSupport::TestCase
#  def setup
#    @game1 = Game.create(
#      id: 1704,
#      sport: "ncaa_football",
#      home_team_name: "ULL",
#      away_team_name: "Appalachian St",
#      date: "Wed, 19 Oct 2016",
#      home_team_massey_line: 14.5,
#      away_team_massey_line: -14.5,
#      home_team_vegas_line: 10.5,
#      away_team_vegas_line: -10.5,
#      vegas_over_under: 0.0,
#      massey_over_under: 50.5,
#      created_at: "Fri, 21 Oct 2016 22:20:33 UTC +00:00",
#      updated_at: "Fri, 21 Oct 2016 22:25:03 UTC +00:00",
#      line_diff: 4.0,
#      over_under_diff: 50.5,
#      team_to_bet: "Appalachian St",
#      over_under_pick: "Over",
#      home_team_final_score: 0,
#      away_team_final_score: 24,
#      week_id: 20_161_017
#    )
#
#    @game2 = Game.create(
#      id: 1708,
#      sport: "ncaa_football",
#      home_team_name: "Fresno St",
#      away_team_name: "San Diego St",
#      date: "Fri, 21 Oct 2016",
#      home_team_massey_line: 17.5,
#      away_team_massey_line: -17.5,
#      home_team_vegas_line: 16.5,
#      away_team_vegas_line: -16.5,
#      vegas_over_under: 0.0,
#      massey_over_under: 51.5,
#      created_at: "Fri, 21 Oct 2016 22:20:33 UTC +00:00",
#      updated_at: "Fri, 21 Oct 2016 22:26:53 UTC +00:00",
#      line_diff: 1.0,
#      over_under_diff: 51.5,
#      team_to_bet: "San Diego St",
#      over_under_pick: "Over",
#      home_team_final_score: 3,
#      away_team_final_score: 17,
#      week_id: 20_161_017
#    )
#
#    @game3 = Game.create(
#      id: 1709,
#      sport: "ncaa_football",
#      home_team_name: "Fresno St",
#      away_team_name: "San Diego St",
#      date: "Fri, 21 Oct 2016",
#      home_team_massey_line: 5,
#      away_team_massey_line: -5,
#      home_team_vegas_line: -2,
#      away_team_vegas_line: 2,
#      team_to_bet: "San Diego St",
#      over_under_pick: "Over",
#      home_team_final_score: 16,
#      away_team_final_score: 1,
#      week_id: 20_161_017
#    )
#
#    @game4 = Game.create(
#      id: 1711,
#      sport: "ncaa_football",
#      home_team_name: "Fresno St",
#      away_team_name: "San Diego St",
#      date: "Fri, 21 Oct 2016",
#      home_team_massey_line: 5,
#      away_team_massey_line: -5,
#      home_team_vegas_line: -2,
#      away_team_vegas_line: 2,
#      team_to_bet: "San Diego St",
#      over_under_pick: "Over",
#      home_team_final_score: 16,
#      away_team_final_score: 20,
#      week_id: 20_161_017
#    )
#
#    @not_over = Game.create(
#      date: Date.today + 1
#      )
#
#    @nil_game = Game.create(
#      id: 1739,
#       sport: "ncaa_football",
#       home_team_name: "Arizona",
#       away_team_name: "USC",
#       home_team_massey_line: 4.5,
#       away_team_massey_line: -4.5,
#       home_team_vegas_line: 7.0,
#       away_team_vegas_line: -7.0,
#       vegas_over_under: 0.0,
#       massey_over_under: 65.5,
#       line_diff: 2.5,
#       over_under_diff: 65.5,
#       team_to_bet: "Arizona",
#       over_under_pick: "Over",
#       home_team_final_score: 14,
#       away_team_final_score: 48,
#       week_id: 20161017
#     )
#    @game5 = Game.create(
#      id: 2751,
#      sport: "ncaa_football",
#      home_team_name: "Texas Tech",
#      away_team_name: "Oklahoma",
#      date: "Sat, 22 Oct 2016",
#      home_team_massey_line: 6.5,
#      away_team_massey_line: -6.5,
#      home_team_vegas_line: 16.0,
#      away_team_vegas_line: -16.0,
#      vegas_over_under: 84.5,
#      massey_over_under: 93.5,
#      line_diff: 9.5,
#      over_under_diff: 9.0,
#      team_to_bet: "Texas Tech",
#      over_under_pick: "Over",
#      home_team_final_score: 52,
#      away_team_final_score: 59,
#      week_id: 20161023,
#      home_team_money_percent: nil,
#      away_team_money_percent: nil,
#      home_team_spread_percent: "36%",
#      away_team_spread_percent: "64%",
#      over_percent: "69%",
#      under_percent: "31%",
#      public_percentage_on_massey_team: 36
#    )
#
#    Game.all.each do |game|
#      Games::Calculate.run(game: game)
#    end
#  end
#
#
#  test 'returns true if massey makes correct pick' do
#    assert @game1.correct_prediction == true
#  end
#
#  test 'returns false if massey makes incorrect pick' do
#    assert @game2.correct_prediction == false
#  end
#
#  test 'returns false if massey is incorrect and lines are past zero' do
#    assert @game3.correct_prediction == false
#  end
#
#  test 'returns true if massey is correct and lines are past zero' do
#    assert @game4.correct_prediction == true
#  end
#
#  test 'returns true if game is over' do
#    assert @game1.game_over == true
#  end
#
#  test 'returns false if game is not over' do
#    assert @not_over.game_over == false
#  end
#
#  test 'correct line prediction does not return nil' do
#    refute @nil_game.correct_prediction.nil?
#  end
#
#  test 'Underdog Covers and massey predicts correct' do
#    assert @game5.correct_prediction == true
#  end
#end
