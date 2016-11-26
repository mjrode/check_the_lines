class Terminal::OutputGames < Less::Interaction
	expects :sport

	def run
    pretty_print(sport)
	end

	private

	def pretty_print(sport)
		Game.all.unplayed.valid_spread.spread_best_bets.each do |game|
			print game.home_team_name
		end
	end
end
