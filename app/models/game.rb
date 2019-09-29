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
#  best_bet                            :boolean
#  processed                           :boolean          default(FALSE)
#  massey_over_under                   :float
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  line_diff                           :float
#  over_under_diff                     :float
#  team_to_bet                         :string
#  over_under_pick                     :string
#  home_team_final_score               :integer
#  away_team_final_score               :integer
#  home_team_money_percent             :string
#  away_team_money_percent             :string
#  home_team_spread_percent            :string
#  away_team_spread_percent            :string
#  over_percent                        :string
#  under_percent                       :string
#  public_percentage_on_massey_team    :integer
#  game_over                           :boolean
#  correct_prediction                  :boolean
#  correct_over_under_prediction       :boolean
#  public_percentage_massey_over_under :integer
#  strength                            :float
#  ou_best_bet                         :boolean
#

class Game < ActiveRecord::Base
  scope :unprocessed,          -> {where(processed: false)}
  scope :unplayed,            -> { where("date > ?", Date.today-3) }
  # TODO: Clean up these scopes.
  scope :game_over,           -> {where(game_over: true)}
  scope :not_over,            -> {where(game_over: false)}
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

  scope :correct_spread_best_bets,       -> (sport) { where(sport: sport, best_bet: true, correct_prediction: true)}
  scope :all_correct_spread_best_bets,   -> { where(best_bet: true, correct_prediction: true)}
  scope :all_incorrect_spread_best_bets, -> { where(best_bet: true, correct_prediction: false)}
  scope :incorrect_spread_best_bets,     -> (sport) { where(sport: sport, best_bet: true, correct_prediction: false)}
  scope :correct_over_under_best_bets,   -> (sport) { where(sport: sport, best_bet: true, correct_over_under_prediction: true)}
  scope :incorrect_over_under_best_bets, -> (sport) { where(sport: sport, best_bet: true, correct_over_under_prediction: false)}
  scope :best_bets,                      -> (sport) {where(best_bet: true, sport: sport)}
  scope :all_best_bets,                  -> { where(best_bet: true)}
  scope :ou_best_bets,                   -> (sport) {where(ou_best_bet: true, sport: sport)}


  scope :incorrect_best_bets, -> {
	  spread_best_bets.where(game_over: true).where(correct_prediction: false).count
  }

 scope :correct_best_bets, -> {
	  spread_best_bets.where(game_over: true).where(correct_prediction: true).count
  }

  def strength
    rlm = send("#{massey_favors_home_or_away}_rlm").to_i
    strength = (line_diff * 100 / (public_percentage_on_massey_team * 5)).round(1) rescue "Wrong"
    if rlm.to_i > 0
      puts "Adding #{send("#{massey_favors_home_or_away}_rlm") / 5} points to #{team_to_bet}"
      strength + send("#{massey_favors_home_or_away}_rlm") / 5
    end
    strength
  end

  def over_under_strength
    (over_under_diff * 100 / public_percentage_on_massey_team).round(2)
  end
end