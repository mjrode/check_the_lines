class Terminal::OutputGames < Less::Interaction
	expects :sport

	def run
    pretty_print(sport)
	end

	private

	def pretty_print(sport)
		Game.best_bets(sport).where(game_over: false).where.not("strength > ?", 10000).sort_by{|game| game.strength }.reverse.each do |game|
			print game.home_team_name
		end
	end
end
