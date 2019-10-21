module GameHelper
  def team_to_bet_name_and_line(game)
    if team_to_bet_line(game) > 0
      return "#{game.team_to_bet} +#{team_to_bet_line(game)}"
    end
    "#{game.team_to_bet} #{team_to_bet_line(game)}"
  end

  def over_under_pick_and_line(game)
    "#{game.over_under_pick} #{game.vegas_over_under}"
  end

  def set_games_for_display(games, sport)
    return games
    # return games unless SPORTS.include?(sport)
    # games.where(sport: sport)
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
end
