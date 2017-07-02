class Games::CalculateAll < Less::Interaction
	def run
		calculate_all
	end

	def calculate_all
    Game.unprocessed.each do |game|
			Games::Calculate.run(game: game)
		end
	end
end
