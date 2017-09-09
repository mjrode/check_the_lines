class Games::CalculateAll < Less::Interaction
	def run
		calculate_all
	end

	def calculate_all
	  Game.where("(game_over = false) or processed = false").each do |game|
	  	next if game.date < Date.today && game.processed == true
			Games::Calculate.run(game: game)
		end

		Game.all.each do |game|
      game.update(best_bet: best_bet?(game), ou_best_bet: ou_best_bet?(game))
		end
  end

	private

	def best_bet?(game)
		line_diff = game.sport == "mlb" ? BEST_BET_SETTINGS[:baseball_line_diff] : BEST_BET_SETTINGS[:line_diff]
		public_percentage = BEST_BET_SETTINGS[:public_percentage]
		(game.line_diff >= line_diff && game.public_percentage_on_massey_team <= public_percentage) ? true : false rescue false
  end

  def ou_best_bet?(game)
    line_diff = game.sport == "mlb" ? BEST_BET_SETTINGS[:baseball_line_diff] : BEST_BET_SETTINGS[:line_diff]
    public_percentage = BEST_BET_SETTINGS[:public_percentage]
    (game.over_under_diff >= line_diff && game.public_percentage_massey_over_under <= public_percentage) ? true : false rescue false
  end
end
