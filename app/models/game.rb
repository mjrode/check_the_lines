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
#

class Game < ActiveRecord::Base
  scope :unplayed,            -> { where("date > ?", Date.today-3) }
  scope :played,              -> { where("date < ?", Date.today) }
  scope :valid_spread,        -> {
    where.not(home_team_vegas_line: 0.0).
    where.not(public_percentage_on_massey_team: nil).
    where.not(home_team_spread_percent: "100").
    where.not(home_team_spread_percent: "0")
  }
  scope :valid_over_under,    -> {
    where.not(vegas_over_under: 0.0).
    where.not(public_percentage_massey_over_under: nil).
    where.not(over_percent: "100").
    where.not(over_percent: "0")
  }
  scope :spread_best_bets,    -> {
    where('line_diff > ?', 3).
    where('public_percentage_on_massey_team < ?', 35)
  }
  scope :over_under_best_bets, -> {
    where('line_diff > ?', 3).
    where('public_percentage_massey_over_under < ?', 35)
  }
	
   scope :incorrect_best_bets, -> {
	  spread_best_bets.where(game_over: true).where(sport: "ncaa_football").where(correct_prediction: false).count	
  }

 scope :correct_best_bets, -> {
	  spread_best_bets.where(game_over: true).where(sport: "ncaa_football").where(correct_prediction: true).count	
  }

  def strength
    return (line_diff * 100 / public_percentage_on_massey_team).round(2) unless public_percentage_on_massey_team.nil?
    0
  end

  def over_under_strength
    return (over_under_diff * 100 / public_percentage_on_massey_team).round(2) unless public_percentage_on_massey_team.nil?
    0
  end
end
