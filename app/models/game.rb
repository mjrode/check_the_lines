class Game < ActiveRecord::Base
  validates :external_id, uniqueness: true

  scope :game_over, -> { where(game_over: true) }
  scope :not_over, -> { where(game_over: false) }
  scope :played, -> { where('date < ?', Date.today) }

  scope :correct_picks,
        -> { where(correct_prediction: true, game_over: true) }
  scope :correct_spread_best_bets,
        -> { where(best_bet: true, correct_prediction: true, game_over: true) }
  scope :best_bets, -> { where(best_bet: true) }

  def strength
    return nil unless massey_favors_home_or_away
    rlm = send("#{massey_favors_home_or_away}_rlm").to_i
    rlm_strength = rlm * RLM_STRENGTH
    line_strength = line_diff * LINE_STRENGTH
    public_percentage_strength =
      (1 / public_percentage_on_massey_team) * PUBLIC_PERCENTAGE_STRENGTH

    strength = line_strength
    strength += public_percentage_strength
    strength += rlm_strength

    if strength > BEST_BET_STRENGTH
      ::RESULTS <<
        "Home Team: #{home_team_name} Away #{away_team_name} Home Final #{
          home_team_final_score
        } Away Final #{away_team_final_score}  Home vegas  #{
          home_team_vegas_line
        } Away Vegas #{away_team_vegas_line}"

      ::RESULTS << "Strength from rlm of #{rlm} is #{rlm_strength}" if rlm_strength
      ::RESULTS << "Strength from line diff of #{line_diff} is #{line_strength}"
      ::RESULTS <<
        "Strength from public % of #{public_percentage_on_massey_team} is #{
          public_percentage_strength
        }"

      ::RESULTS << "Correct pick #{correct_prediction}"
      ::RESULTS << "Final Strength: #{strength.round(2)} \n\n"
    end
    strength.round(2)
  end

  def over_under_strength
    (over_under_diff * 100 / public_percentage_on_massey_team).round(2)
  end
end
