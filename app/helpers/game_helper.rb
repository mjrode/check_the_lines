module GameHelper

  def team_to_bet_name_and_line(game)
    "#{game.team_to_bet} | #{team_to_bet_line(game)}"
  end

  def team_to_bet_line(game)
    return game.home_team_vegas_line if game.home_team_name == game.team_to_bet
    game.away_team_vegas_line
  end
end
