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
      home_team_line_diff: home_line_diff,
      away_team_line_diff: away_line_diff,
      over_under_diff: over_under_diff,
      over_under_pick: pick_over_under,
      public_percentage_on_massey_team: get_public_percentage_on_massey_team,
      massey_favors_home_or_away: massey_favors_home_or_away,
      public_percentage_massey_over_under:
        get_public_percentage_massey_over_under,
      correct_over_under_prediction: correct_over_under_prediction?,
      in_progress: in_progress?,
      home_team_strength: home_team_strength,
      away_team_strength: away_team_strength,
      best_bet: best_bet?,
      team_to_bet: strength_team_to_bet,
      correct_prediction: correct_line_prediction?,
      best_bet_strength: best_bet_strength
    }
  end

  def home_action_line_diff
    game.edge_data['math_model']['home_true_spread'] - game.home_team_vegas_line
  rescue NoMethodError
    puts "No math model for game external id #{game.external_id}"
    0
  end

  def away_action_line_diff
    game.edge_data['math_model']['away_true_spread'] - game.away_team_vegas_line
  rescue NoMethodError
    puts "No math model for game external id #{game.external_id}"
    0
  end

  def home_line_diff
    return nil if game.home_team_massey_line.nil? || game.home_team_vegas_line.nil?
    game.home_team_massey_line - game.home_team_vegas_line
  end

  def away_line_diff
    return nil if game.away_team_massey_line.nil? || game.away_team_vegas_line.nil?
    game.away_team_massey_line - game.away_team_vegas_line
  end

  def massey_favors_home_or_away
    return 'away' if massey_team_to_bet == game.away_team_name
    'home'
  end

  def best_bet?
    home_team_strength.to_i < BEST_BET_STRENGTH || away_team_strength.to_i < BEST_BET_STRENGTH
  end

  def home_team_strength
    @home_team_strength ||= strength('home')
  end

  def away_team_strength
    @away_team_strength ||= strength('away')
  end

  def set_line_strength(params)
    # params[:line_strength].to_i > 1 && params[:action_line_strength].to_i > 1 ? 1 : 0
     params[:action_line_strength].to_i > 1 ? 1 : 0
  end

  def strength(home_or_away)
    strength_params = set_strength_params(home_or_away)
    # strength = 0 #set_line_strength(strength_params)
    strength =  set_line_strength(strength_params)
    strength += strength_params[:public_percentage_strength].to_i
    strength += strength_params[:rlm_strength].to_i
    strength += strength_params[:contrarian_strength].to_i
    strength += strength_params[:steam_strength].to_i
    strength += strength_params[:overall_rating_strength].to_i
    strength += strength_params[:experts_strength].to_i
    strength += strength_params[:sharp_money_strength].to_i
    # print_strength_results(strength_params, strength, home_or_away) if strength > BEST_BET_STRENGTH

    strength.round(2)
  end

  def set_strength_params(home_or_away)
    pub_percent = game.send("#{home_or_away}_team_spread_percent").to_i
    rlm = game.send("#{home_or_away}_rlm").to_i
    steam = game.send("#{home_or_away}_steam").to_i
    overall_rating = game.send("#{home_or_away}_overall_rating").to_i
    contrarian = game.send("#{home_or_away}_contrarian").to_i
    experts_pick = experts_favor(game, home_or_away)
    sharp_money_percentage = get_sharp_money_percentage(game, home_or_away)


    overall_rating_strength = overall_rating * OVERALL_RATING_STRENGTH
    rlm_strength = rlm * RLM_STRENGTH
    rlm_strength = 1 if rlm.positive?
    line_strength = [LINE_STRENGTH * send("#{home_or_away}_line_diff").to_i, 0].max
    action_line_strength = [LINE_STRENGTH * send("#{home_or_away}_action_line_diff").to_i, 0].max
    # public_percentage_strength = 5 * PUBLIC_PERCENTAGE_STRENGTH if pub_percent <= 35
    public_percentage_strength = 1 if pub_percent <= 35
    # steam_strength = STEAM_STRENGTH * steam
    steam_strength = 1 if steam.positive?
    contrarian_strength = CONTRARIAN_STRENGTH * contrarian
    # experts_strength = EXPERTS_STRENGTH * experts_pick
    experts_strength = 1 if experts_pick.positive?
    # sharp_money_strength = SHARP_MONEY_STRENGTH * sharp_money_percentage
    sharp_money_strength = 1 if sharp_money_percentage.positive?

    {
      rlm: rlm,
      rlm_strength: rlm_strength,
      steam: steam,
      steam_strength: steam_strength,
      contrarian: contrarian,
      contrarian_strength: contrarian_strength,
      overall_rating: overall_rating,
      overall_rating_strength: overall_rating_strength,
      line_strength: line_strength,
      action_line_strength: action_line_strength,
      public_percentage_strength: public_percentage_strength.to_i,
      pub_percent: pub_percent.to_f,
      home_away: home_or_away,
      experts_strength: experts_strength,
      experts_pick: experts_pick,
      sharp_money_percentage: sharp_money_percentage,
      sharp_money_strength: sharp_money_strength,
    }
  end

  def experts_favor(game, home_away)
    team_to_check = home_away
    opposing_team = home_away == 'home' ? 'away' : 'home'
    favored = game.edge_data['signals']['spread'][team_to_check] - game.edge_data['signals']['spread'][opposing_team]
    favored.positive? ? favored : 0
  end

  def get_sharp_money_percentage(game, home_away)
    team_sharp_money = game.edge_data['sharp_money']["spread_#{home_away}_money"]
    percentage = (100 - team_sharp_money) - team_sharp_money
    percentage.positive? ? percentage : 0
  end

  def print_strength_results(strength_params, strength, home_or_away)
    ::RESULTS <<
      "Home Team: #{game.home_team_name} Away #{game.away_team_name} Home Final #{
        game.home_team_final_score
      } Away Final #{game.away_team_final_score}  Home vegas  #{
        game.home_team_vegas_line
      } Away Vegas #{game.away_team_vegas_line}"

    ::RESULTS << "Strength from rlm of #{strength_params[:rlm]} is #{strength_params[:rlm_strength]}" if strength_params[:rlm_strength]
    ::RESULTS << "Strength from steam of #{strength_params[:steam]} is #{strength_params[:rlm_strength]}" if strength_params[:steam_strength]
    ::RESULTS << "Strength from contrarian of #{strength_params[:contrarian]} is #{strength_params[:contrarian_strength]}" if strength_params[:contrarian_strength]
    ::RESULTS << "Strength from overall_rating of #{strength_params[:overall_rating]} is #{strength_params[:overall_rating_strength]}" if strength_params[:overall_rating_strength]
    ::RESULTS << "Strength from line diff of #{send("#{home_or_away}_line_diff")} is #{strength_params[:line_strength]}"
    ::RESULTS <<
      "Strength from public % of #{strength_params[:pub_percent]} is #{
        strength_params[:public_percentage_strength]
      }"

    ::RESULTS << "Final Strength: #{strength.round(2)} \n\n"
  end

  def over_under_diff
    return nil if game.massey_over_under.nil? || game.vegas_over_under.nil?
    game.massey_over_under - game.vegas_over_under
  end

  def massey_team_to_bet
    massey_selected_away_team? ? game.away_team_name : game.home_team_name
  end

  def massey_selected_away_team?
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
    return game.home_team_spread_percent if massey_team_to_bet == game.home_team_name
    game.away_team_spread_percent if massey_team_to_bet == game.away_team_name
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
    strength_team_to_bet == game.away_team_name ? 'away' : 'home'
  end

  def strength_team_to_bet
    home_team_strength > away_team_strength ? game.home_team_name : game.away_team_name
  end

  def best_bet_strength
    [home_team_strength, away_team_strength].max
  end
end