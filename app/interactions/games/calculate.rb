class Games::Calculate < Less::Interaction
  expects :game

  def run
    calculate_picks
  end

  private

  def calculate_picks
    game.update(set_game_hash)
  end

  def set_game_hash
    {
      line_diff: line_diff,
      over_under_diff: over_under_diff,
      team_to_bet: find_team_to_bet,
      over_under_pick: pick_over_under,
      public_percentage_on_massey_team: get_public_percentage_on_massey_team,
      massey_favors_home_or_away: massey_favors_home_or_away,
      public_percentage_massey_over_under:
        get_public_percentage_massey_over_under,
      correct_over_under_prediction: correct_over_under_prediction?,
      correct_prediction: correct_line_prediction?,
      # TODO: Need to find a way to set this
      # ou_best_bet: ou_best_bet?,
      in_progress: in_progress?,
      strength: strength,
      best_bet: best_bet?
    }
  end

  def line_diff
    return nil if game.home_team_massey_line.nil? || game.home_team_vegas_line.nil?
    (game.home_team_massey_line - game.home_team_vegas_line).abs
  end

  def massey_favors_home_or_away
    return 'away' if find_team_to_bet == game.away_team_name
    'home'
  end

  def best_bet?
    strength.to_i > BEST_BET_STRENGTH
  end

  def strength
    return nil if massey_favors_home_or_away.nil? || line_diff.nil? || get_public_percentage_on_massey_team.nil?

    strength_params = set_strength_params
    strength = strength_params[:line_strength]
    strength += strength_params[:public_percentage_strength]
    strength += strength_params[:rlm_strength]

    print_strength_results(strength_params, strength) if strength > BEST_BET_STRENGTH

    strength.round(2)
  end

  def set_strength_params
    pub_percent_on_massey = get_public_percentage_on_massey_team
    rlm = game.send("#{massey_favors_home_or_away}_rlm").to_i
    rlm_strength = rlm * RLM_STRENGTH
    line_strength = line_diff * LINE_STRENGTH
    public_percentage_strength =
      (1 / pub_percent_on_massey.to_f) * PUBLIC_PERCENTAGE_STRENGTH

    {
      rlm: rlm,
      rlm_strength: rlm_strength,
      line_strength: line_strength,
      public_percentage_strength: public_percentage_strength,
      pub_percent_on_massey: pub_percent_on_massey.to_f
    }
  end

  def print_strength_results(strength_params, strength)
    ::RESULTS <<
      "Home Team: #{game.home_team_name} Away #{game.away_team_name} Home Final #{
        game.home_team_final_score
      } Away Final #{game.away_team_final_score}  Home vegas  #{
        game.home_team_vegas_line
      } Away Vegas #{game.away_team_vegas_line}"

    ::RESULTS << "Strength from rlm of #{strength_params[:rlm]} is #{strength_params[:rlm_strength]}" if strength_params[:rlm_strength]
    ::RESULTS << "Strength from line diff of #{line_diff} is #{strength_params[:line_strength]}"
    ::RESULTS <<
      "Strength from public % of #{strength_params[:pub_percent_on_massey]} is #{
        strength_params[:public_percentage_strength]
      }"

    ::RESULTS << "Correct pick #{correct_line_prediction?}"
    ::RESULTS << "Final Strength: #{strength.round(2)} \n\n"
  end

  def over_under_diff
    return nil if game.massey_over_under.nil? || game.vegas_over_under.nil?
    game.massey_over_under - game.vegas_over_under
  end

  def find_team_to_bet
    home_team_won ? game.away_team_name : game.home_team_name
  end

  def home_team_won
    return nil if game.home_team_massey_line.nil? || game.home_team_vegas_line.nil?
    (game.home_team_massey_line - game.home_team_vegas_line).positive?
  end

  def pick_over_under
    over_covered ? 'Over' : 'Under'
  end

  def in_progress?
    !(game.time.include?('P.M.') || game.time.include?('A.M.'))
  end

  def over_covered
    return nil if game.massey_over_under.nil? || game.vegas_over_under.nil?
    (game.massey_over_under - game.vegas_over_under).positive?
  end

  def get_public_percentage_on_massey_team
    return game.home_team_spread_percent if find_team_to_bet == game.home_team_name
    game.away_team_spread_percent if find_team_to_bet == game.away_team_name
  end

  def get_public_percentage_massey_over_under
    return game.over_percent.to_i if pick_over_under == 'Over'
    game.under_percent.to_i if pick_over_under == 'Under'
  end

  def correct_over_under_prediction?
    return nil unless game.game_over
    return true if correct_over_pick || correct_under_pick
    false
  end

  def correct_over_pick
    pick_over_under == 'Over' && game_total > game.vegas_over_under
  rescue NoMethodError
    nil
  end

  def correct_under_pick
    pick_over_under == 'Under' && game_total < game.vegas_over_under
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
    team_to_bet_home_or_away? == 'home' ? correct_home_prediction : correct_away_prediction
  end

  def correct_home_prediction
    return if game.home_team_vegas_line.nil? || actual_home_line.nil?
    game.home_team_vegas_line > actual_home_line
  end

  def correct_away_prediction
    return if game.away_team_vegas_line.nil? || actual_home_line.nil?
    game.away_team_vegas_line > actual_away_line
  end

  def actual_home_line
    return if invalid_final_score?
    (game.away_team_final_score - game.home_team_final_score)
  end

  def actual_away_line
    return if invalid_final_score?
    (game.home_team_final_score - game.away_team_final_score)
  end

  def invalid_final_score?
    game.home_team_final_score.nil? || game.away_team_final_score.nil?
  end

  def team_to_bet_home_or_away?
    return 'away' if find_team_to_bet == game.away_team_name
    'home'
  end
end