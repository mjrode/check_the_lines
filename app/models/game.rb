class Game < ActiveRecord::Base
  scope :unprocessed,          -> {where(processed: false)}
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
  scope :low_public_percentage_and_correct,    -> {
    where('public_percentage_on_massey_team < ?', 35)
    where(correct_prediction: true, game_over: true)
  }
  scope :low_public_percentage,    -> {
    where('public_percentage_on_massey_team < ?', 35)
    where(game_over: true)
  }

  scope :correct_spread_best_bets,       -> (sport) { where(sport: sport, best_bet: true, correct_prediction: true)}
  scope :all_correct_picks,              -> { where(correct_prediction: true, game_over: true)}
  scope :all_correct_spread_best_bets,   -> { where(best_bet: true, correct_prediction: true, game_over: true)}
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
    return nil unless massey_favors_home_or_away
    rlm = send("#{massey_favors_home_or_away}_rlm").to_i
    rlm_strength = (rlm / 5) if rlm.to_i > 0
    line_strength = line_diff / 2
    strength = line_strength

    strength += strength_from_public_percentage
    strength += (rlm / 2) if rlm.to_i > 0

    if strength > 3 && public_percentage_on_massey_team < 35
      puts "Home Team: #{home_team_name} Away #{away_team_name} Home Final #{home_team_final_score} Away Final #{away_team_final_score}  Home vegas  #{home_team_vegas_line} Away Vegas #{away_team_vegas_line}"
      puts "Strength from rlm of #{rlm} is #{rlm_strength}" if rlm_strength

      puts "Strength from line diff of #{line_diff} is #{line_strength}"

      puts "Strength from public % of #{public_percentage_on_massey_team} is #{strength_from_public_percentage.round(2)}"

      puts "Correct pick #{correct_prediction}"
      puts "Final Strength: #{strength.round(2)} \n\n"
    end
    strength.round(2)
  end

  def strength_from_public_percentage
    public_percentage_on_massey_team > BEST_BET_SETTINGS[:public_percentage] ? 0 : (1.to_f / (public_percentage_on_massey_team.to_f / 80))
  end

  def over_under_strength
    (over_under_diff * 100 / public_percentage_on_massey_team).round(2)
  end
end