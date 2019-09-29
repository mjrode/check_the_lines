class Games::Calculate < Less::Interaction
  expects :game

  def run
    calculate_picks
  end

  private

  def calculate_picks
    game.update(game_params)
    game.update({
      public_percentage_on_massey_team: get_public_percentage_on_massey_team,
      massey_favors_home_or_away: massey_favors_home_or_away,
      public_percentage_massey_over_under: get_public_percentage_massey_over_under,
      correct_over_under_prediction: correct_over_under_prediction?,
      correct_prediction:  correct_line_prediction?,
      best_bet: best_bet?,
       ou_best_bet: ou_best_bet?

      })
    game.update(strength: game_strength)
  end

  def game_params
    params = {
      line_diff: line_diff,
      over_under_diff: over_under_diff,
      team_to_bet: find_team_to_bet,
      over_under_pick: pick_over_under,
    }
    params[:processed] = true if game.game_over
    params
  end

	def game_strength
		game.strength
	end

  def line_diff
    (game.home_team_massey_line - game.home_team_vegas_line).abs
  end

  def massey_favors_home_or_away
    return "away" if game.team_to_bet == game.away_team_name
    "home"
  end

  def best_bet?
    line_diff = game.sport == "mlb" ? BEST_BET_SETTINGS[:baseball_line_diff] : BEST_BET_SETTINGS[:line_diff]
    public_percentage = BEST_BET_SETTINGS[:public_percentage]
    (game.line_diff >= line_diff && game.public_percentage_on_massey_team <= public_percentage) ? true : false rescue false
  end

  def ou_best_bet?
    line_diff = game.sport == "mlb" ? BEST_BET_SETTINGS[:baseball_line_diff] : BEST_BET_SETTINGS[:line_diff]
    public_percentage = BEST_BET_SETTINGS[:public_percentage]
    (game.over_under_diff >= line_diff && game.public_percentage_massey_over_under <= public_percentage) ? true : false rescue false
  end

  def over_under_diff
    game.massey_over_under - game.vegas_over_under rescue nil
  end

  def find_team_to_bet
    if home_team_won
      game.away_team_name
    else
      game.home_team_name
    end
  end

  def home_team_won
    game.home_team_massey_line - game.home_team_vegas_line > 0
  end

  def pick_over_under
    if over_covered
      "Over"
    else
      "Under"
    end
  end

  def over_covered
    game.massey_over_under - game.vegas_over_under > 0
  end

  def get_public_percentage_on_massey_team
    return game.home_team_spread_percent if game.team_to_bet == game.home_team_name
    game.away_team_spread_percent if game.team_to_bet == game.away_team_name
  end

  def get_public_percentage_massey_over_under
    return game.over_percent.to_i if game.over_under_pick == "Over"
    game.under_percent.to_i if game.over_under_pick =="Under"
  end

  def correct_over_under_prediction?
    return nil unless game.game_over
    return true if correct_over_pick || correct_under_pick
    false
  end

  def correct_over_pick
    game.over_under_pick == 'Over' && game_total > game.vegas_over_under
  rescue NoMethodError
    nil
  end

  def correct_under_pick
    game.over_under_pick == 'Under' && game_total < game.vegas_over_under
  rescue NoMethodError
    nil
  end

  def game_total
    game.away_team_final_score + game.home_team_final_score
  rescue NoMethodError
    nil
  end

  def correct_line_prediction?
    return nil unless game.game_over
    return correct_home_prediction if team_to_bet_home_or_away? == "home"
    correct_away_prediction
  end

  def correct_home_prediction
    game.home_team_vegas_line > actual_home_line unless game.home_team_vegas_line.nil? || actual_home_line.nil?
  end

  def correct_away_prediction
    game.away_team_vegas_line > actual_away_line unless game.away_team_vegas_line.nil? || actual_home_line.nil?
  end

  def actual_home_line
    (game.away_team_final_score - game.home_team_final_score) unless invalid_final_score?
  end

  def actual_away_line
    (game.home_team_final_score - game.away_team_final_score) unless invalid_final_score?
  end

  def invalid_final_score?
    game.home_team_final_score.nil? || game.away_team_final_score.nil?
  end

  def team_to_bet_home_or_away?
    return "away" if game.team_to_bet == game.away_team_name
    "home"
  end
end
