module NcaafHelper

  def team_to_bet?(game)
    return "#{game.team_to_bet} +#{team_to_bet_line(game)}" if team_to_bet_line(game) > 0
		"#{game.team_to_bet} #{team_to_bet_line(game)}"
  end

end
