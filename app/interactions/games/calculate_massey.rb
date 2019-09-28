class Games::CalculateMassey < Less::Interaction
  expects :massey_game

  def run
    calculate_picks
  end

  private

  def calculate_picks
    massey_game.update(game_params)
  end

  def game_params
    {
      line_diff: line_diff,
      team_to_bet: find_team_to_bet
    }
  end


  def line_diff
    (massey_game.home_team_massey_line - massey_game.home_team_vegas_line).abs
  end
  #
  # def over_under_diff
  #   massey_game.massey_over_under - massey_game.vegas_over_under rescue nil
  # end

  def find_team_to_bet
    if home_team_won
      massey_game.away_team_name
    else
      massey_game.home_team_name
    end
  end

  def home_team_won
    massey_game.home_team_massey_line - massey_game.home_team_vegas_line > 0
  end

  def pick_over_under
    over_covered ? "Over" : "Under"
  end

  def over_covered
    massey_game.massey_over_under - massey_game.vegas_over_under > 0
  end

  def correct_over_under_prediction?
    return nil unless massey_game.game_over
    return true if correct_over_pick || correct_under_pick
    false
  end

  def correct_over_pick
    game.over_under_pick == 'Over' && game_total > game.vegas_over_under
  rescue NoMethodError
    nil
  end

  def correct_under_pick
    massey_game.over_under_pick == 'Under' && game_total < massey_game.vegas_over_under
  rescue NoMethodError
    nil
  end

  def game_total
    massey_game.away_team_final_score + massey_game.home_team_final_score
  rescue NoMethodError
    nil
  end

  def correct_line_prediction?
    return nil unless game.game_over
    return correct_home_prediction if team_to_bet_home_or_away? == "home"
    correct_away_prediction
  end

  def team_to_bet_home_or_away?
    return "away" if massey_game.team_to_bet == massey_game.away_team_name
    "home"
  end
end
