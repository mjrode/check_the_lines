module GameHelper
  def team_to_bet_name_and_line(game)
    if team_to_bet_line(game).positive?
      return "#{game.team_to_bet} +#{team_to_bet_line(game)}"
    end
    "#{game.team_to_bet} #{team_to_bet_line(game)}"
  end

  def over_under_pick_and_line(game)
    "#{game.over_under_pick} #{game.vegas_over_under}"
  end

  def set_filter_url(sport, game_filter)
    case sport
    when 'nfl'
      nfl_games_path(game_filter: game_filter)
    when 'ncaaf'
      ncaaf_games_path(game_filter: game_filter)
    when 'best_bets'
      best_bets_games_path(game_filter: game_filter)
    end
  end

  def team_to_bet_line(game)
    return game.home_team_vegas_line if game.home_team_name == game.team_to_bet
    game.away_team_vegas_line
  end

  def sharp_money_percentage(game, home_away)
    sharp_money = game.edge_data['sharp_money']
    return nil unless sharp_money
    team_sharp_money = sharp_money["spread_#{home_away}_money"]
    percentage = (100 - team_sharp_money) - team_sharp_money
    percentage.positive? ? percentage : nil
  end

  def sharp_projected_line(game, home_away)
    game.edge_data['math_model']["#{home_away}_true_spread"]
  rescue NoMethodError
    puts "Error in sharp projected line game id #{game.external_id}"
    nil
  end

  def sharp_expert_count(game, home_away)
    game.edge_data['signals']['spread'][home_away]
  rescue NoMethodError
    puts "Error in sharp expert count game id #{game.external_id}"
    nil
  end
end
